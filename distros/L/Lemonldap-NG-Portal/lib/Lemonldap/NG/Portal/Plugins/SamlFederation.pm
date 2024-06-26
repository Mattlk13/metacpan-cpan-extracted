package Lemonldap::NG::Portal::Plugins::SamlFederation;

use strict;
use Mouse;
use Lemonldap::NG::Portal::Main::Constants qw( PE_OK);
use Carp qw(croak);
use XML::LibXML::Reader;

our $VERSION = '2.0.16';

use constant hook => { getSamlConfig => 'getSamlConfig' };

extends qw( Lemonldap::NG::Portal::Main::Plugin );

# TTL for found providers
has default_ttl => ( is => 'rw', default => '3600' );

# How long before we retry when an entityID was not found
has default_notfound_ttl => ( is => 'rw', default => '60' );

sub getSamlConfig {
    my ( $self, $req, $entityID, $config ) = @_;

    %$config = %{ $self->get_config_info_federation($entityID) };
    return PE_OK;

}

sub get_config_info_federation {
    my ( $self, $entityID ) = @_;

    my $config = $self->get_config_info_from_xml_federation($entityID) || {};

    # Default negative TTL
    $config->{ttl} ||= $self->default_notfound_ttl;

    if ( $config->{sp_metadata} ) {

        $self->get_sp_config_from_placeholders( $entityID, $config );
    }

    if ( $config->{idp_metadata} ) {
        $self->get_idp_config_from_placeholders( $entityID, $config );
    }
    return $config;
}

sub get_idp_config_from_placeholders {
    my ( $self, $entityID, $config ) = @_;
    my $federation_name = $config->{federation_name};
    my $idp_metadata    = $config->{idp_metadata};

    my $options    = {};
    my $attributes = {};
    my $idpConfKey = $self->lookup_llng_config( $entityID, "IDP" );
    if ($idpConfKey) {
        $self->logger->debug("Configuration $idpConfKey matches $entityID");
        $attributes =
          $self->conf->{samlIDPMetaDataExportedAttributes}->{$idpConfKey};
        $options = $self->conf->{samlIDPMetaDataOptions}->{$idpConfKey};
    }
    else {
        $idpConfKey = "fed:$entityID";
        my $federationConfKey =
          $self->lookup_llng_config( $federation_name, "IDP" );
        if ($federationConfKey) {
            $self->logger->debug(
                "Using federation defaults $federationConfKey for $entityID");
            $options =
              $self->conf->{samlIDPMetaDataOptions}->{$federationConfKey};
            $attributes =
              $self->conf->{samlIDPMetaDataExportedAttributes}
              ->{$federationConfKey};
        }
    }

    $config->{idp_confKey}    = $idpConfKey;
    $config->{idp_attributes} = $attributes;
    $config->{idp_options}    = $options;
    return;
}

sub get_sp_config_from_placeholders {
    my ( $self, $entityID, $config ) = @_;

    my $federation_name = $config->{federation_name};
    my $sp_metadata     = $config->{sp_metadata};
    my $attributes      = $config->{sp_attributes};

    my $options   = {};
    my $macros    = {};
    my $spConfKey = $self->lookup_llng_config( $entityID, "SP" );
    if ($spConfKey) {
        $self->logger->debug("Configuration $spConfKey matches $entityID");
        $attributes =
          $self->configure_attributes_for_sp( $spConfKey, $attributes );
        $options = $self->conf->{samlSPMetaDataOptions}->{$spConfKey};
        $macros  = $self->conf->{samlSPMetaDataMacros}->{$spConfKey};
    }
    else {
        $spConfKey = "fed:$entityID";
        my $federationConfKey =
          $self->lookup_llng_config( $federation_name, "SP" );
        if ($federationConfKey) {
            $self->logger->debug(
                "Using federation defaults $federationConfKey for $entityID");
            $options =
              $self->conf->{samlSPMetaDataOptions}->{$federationConfKey};
            $attributes =
              $self->configure_attributes_for_sp( $federationConfKey,
                $attributes );
        }
    }

    # handle eduPersonTargetedID
    if ( $attributes->{eduPersonTargetedID} ) {
        delete $attributes->{eduPersonTargetedID};
        $options->{samlSPMetaDataOptionsNameIDFormat} = 'persistent';
    }

    $config->{sp_confKey}    = $spConfKey;
    $config->{sp_attributes} = $attributes;
    $config->{sp_options}    = $options;
    $config->{sp_macros}     = $macros;
    return;
}

sub configure_attributes_for_sp {
    my ( $self, $confKey, $attributes_meta ) = @_;

    my $result =
      { %{ $self->conf->{samlSPMetaDataExportedAttributes}->{$confKey} || {} }
      };

    for my $attr ( keys %{ $attributes_meta || {} } ) {

        # Explicit configuration overrides SP from metadata
        next if $result->{$attr};

        my @conf     = split( /;/, $attributes_meta->{$attr} );
        my $required = $conf[0];
        my $policy;
        if ($required) {
            $policy =
              $self->conf->{samlSPMetaDataOptions}->{$confKey}
              ->{samlSPMetaDataOptionsFederationRequiredAttributes}
              || '';
        }
        else {
            $policy =
              $self->conf->{samlSPMetaDataOptions}->{$confKey}
              ->{samlSPMetaDataOptionsFederationOptionalAttributes}
              || '';
        }

        if ( $policy eq "optional" ) {
            $required = 0;
        }
        if ( $policy ne "ignore" ) {
            $result->{$attr} = join( ";", $required, splice( @conf, 1 ) );
        }
    }
    return $result;
}

sub get_config_info_from_xml_federation {
    my ( $self, $entityID ) = @_;

    my @federation_files =
      split( /[\s;,]+/, $self->conf->{samlFederationFiles} );
    my $info;
    for my $file (@federation_files) {
        $info = $self->get_federation( $file, $entityID );
        last if $info;
    }
    return unless defined $info;

    my $partner = $info->{metadata};

    my $result =
      { federation_name => $info->{federation}, ttl => $info->{ttl} };

    # Add required XML namespaces
    $partner->setNamespace( "urn:oasis:names:tc:SAML:2.0:metadata", "md", 0 );
    $partner->setNamespace( "urn:oasis:names:tc:SAML:metadata:attribute",
        "mdattr", 0 );
    $partner->setNamespace( "urn:oasis:names:tc:SAML:2.0:assertion",
        "saml", 0 );
    $partner->setNamespace( "http://www.w3.org/2000/09/xmldsig#", "ds", 0 );

    # Parse subject-id:req extension
    my $requested_subject_id = "none";
    if (
        my $subjectid = $partner->findnodes(
                './md:Extensions'
              . '/mdattr:EntityAttributes'
              . '/saml:Attribute[@Name="urn:oasis:names:tc:SAML:profiles:subject-id:req"]'
              . '/saml:AttributeValue[1]'
              . '/text()'
        )->shift()
      )
    {
        $requested_subject_id = $subjectid->toString;
    }

    # Check IDP or SP
    if ( my $idp = $partner->findnodes('./md:IDPSSODescriptor') ) {

        # Check if SAML 2.0 is supported
        if (
            $partner->findnodes(
'./md:IDPSSODescriptor/md:SingleSignOnService[contains(@Binding,"urn:oasis:names:tc:SAML:2.0:")]'
            )
          )
        {

            $self->logger->debug("Found IDP metadata for $entityID");

            # Read metadata
            my $partner_metadata = $partner->toString;
            $partner_metadata =~ s/\n//g;
            $result->{idp_metadata} = $partner_metadata;

        }
    }
    if ( my $sp = $partner->findnodes('./md:SPSSODescriptor') ) {

        # Check if SAML 2.0 is supported
        if (
            $partner->findnodes(
'./md:SPSSODescriptor/md:AssertionConsumerService[contains(@Binding,"urn:oasis:names:tc:SAML:2.0:")]'
            )
          )
        {
            $self->logger->debug("Found SP metadata for $entityID");

            # Read requested attributes
            my $requestedAttributes = {};
            if (
                $partner->findnodes(
'./md:SPSSODescriptor/md:AttributeConsumingService/md:RequestedAttribute'
                )
              )
            {
                foreach my $requestedAttribute (
                    $partner->findnodes(
'./md:SPSSODescriptor/md:AttributeConsumingService/md:RequestedAttribute'
                    )
                  )
                {
                    my $name = $requestedAttribute->getAttribute("Name");
                    my $friendlyname =
                      $requestedAttribute->getAttribute("FriendlyName");
                    my $nameformat =
                      $requestedAttribute->getAttribute("NameFormat");
                    my $required =
                      ( $requestedAttribute->getAttribute("isRequired")
                          || '' =~ /true/i ) ? 1 : 0;

                    if ($friendlyname) {
                        $self->logger->debug( "Attribute $friendlyname ($name)"
                              . " requested by SP $entityID\n" );

                        $requestedAttributes->{$friendlyname} =
                          "$required;$name;$nameformat;$friendlyname";
                    }
                }
            }

            if (   $requested_subject_id eq "any"
                or $requested_subject_id eq "subject-id" )
            {
                # any or subject-id means that the attribute is required
                $requestedAttributes->{"subjectId"} = join( ";",
                    "1",
                    "urn:oasis:names:tc:SAML:attribute:subject-id",
                    "urn:oasis:names:tc:SAML:2.0:attrname-format:uri",
                    "subject-id" );
            }

            # Remove AttributeConsumingService node
            foreach (
                $partner->findnodes(
                    './md:SPSSODescriptor/md:AttributeConsumingService')
              )
            {
                $_->unbindNode;
            }

            # Read metadata
            my $partner_metadata = $partner->toString;
            $partner_metadata =~ s/\n//g;
            $result->{sp_attributes} = $requestedAttributes;
            $result->{sp_metadata}   = $partner_metadata;
        }
        else {
            $self->logger->warn(
"SP $entityID is not compatible with SAML 2.0, it will not be imported"
            );
        }

    }
    return $result;
}

# This method returns the federation ID and metadata for a given entityID
# Returns
# {
#   metadata => XML::LibXML::Node,
#   federation => 'Name' of federation,
# } or undef
sub get_federation {
    my ( $self, $file, $entityID ) = @_;

    my $reader = XML::LibXML::Reader->new( location => $file );
    my $federation_name;
    my $cache_duration;

    if ( !$reader ) {
        $self->logger->warn("Could not open federation metadata at $file");
        return;
    }

    # Find federation name
    if (
        $reader->nextElement(
            "EntitiesDescriptor", "urn:oasis:names:tc:SAML:2.0:metadata"
        )
      )
    {
        $federation_name = $reader->getAttribute('Name');
        $cache_duration =
        eval { parse_duration( $reader->getAttribute('cacheDuration') ) }
        || $self->default_ttl;
    }
    else {
        $self->logger->warn(
            "Federation metadata $file does not contain an EntitiesDescriptor");
        return;
    }

    # To avoid exhausting all memory,
    # we only parse one EntityDescriptor at a time
    while (
        $reader->nextElement( "EntityDescriptor",
            "urn:oasis:names:tc:SAML:2.0:metadata" ) > 0
      )
    {

        my $current_entityID = $reader->getAttribute('entityID');
        if ( $current_entityID eq $entityID ) {

            $self->logger->debug( "Found $entityID in SAML Federation"
                  . " $federation_name from $file" );

            my $partner = $reader->copyCurrentNode(1);
            return {
                metadata   => $partner,
                federation => $federation_name,
                ttl        => $cache_duration,
            };
        }
    }

    # Return undef if nothing was found
    return;
}

sub lookup_llng_config {
    my ( $self, $entityID, $role ) = @_;
    my $xml = $self->conf->{"saml${role}MetaDataOptions"} || {};
    for my $confKey ( keys %$xml ) {
        if ( (
                $xml->{$confKey}
                ->{"saml${role}MetaDataOptionsFederationEntityID"} || ""
            ) eq $entityID
          )
        {
            return $confKey;
        }
    }
    return;
}

# from https://metacpan.org/pod/DateTime::Format::Duration::XSD
sub parse_duration {
    my ($xs_duration) = @_;
    my ( $neg, $year, $mounth, $day, $hour, $min, $sec, $fsec );
    if (
        $xs_duration =~ /^(-)?
                          P
                          ((\d+)Y)?
                          ((\d+)M)?
                          ((\d+)D)?
                          (
                          T
                          ((\d+)H)?
                          ((\d+)M)?
                          (((\d+)(\.(\d+))?)S)?
                          )?
                         $/x
      )
    {
        ( $neg, $year, $mounth, $day, $hour, $min, $sec, $fsec ) = (
            $1, $3 || 0, $5 || 0, $7 || 0,
            $10 || 0, $12 || 0, $15 || 0, $17 || 0
        );
        unless ( grep { defined } ( $year, $mounth, $day, $hour, $min, $sec ) )
        {
            croak "duration contains no data '$xs_duration'";
        }
    }
    else {
        croak "duration string does not match standart: '$xs_duration'";
    }
    return ( 86400 * 365 * $year +
          86400 * 30 * $mounth +
          86400 * $day +
          3600 * $hour +
          60 * $min +
          $sec );
}

1;
