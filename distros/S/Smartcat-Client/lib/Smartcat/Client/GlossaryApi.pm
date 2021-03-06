
=begin comment

Smartcat Integration API

No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)

OpenAPI spec version: v1

Generated by: https://github.com/swagger-api/swagger-codegen.git

=end comment

=cut

#
# NOTE: This class is auto generated by the swagger code generator program.
# Do not edit the class manually.
# Ref: https://github.com/swagger-api/swagger-codegen
#
package Smartcat::Client::GlossaryApi;

require 5.6.0;
use strict;
use warnings;
use utf8;
use Exporter;
use Carp qw( croak );
use Log::Any qw($log);

use Smartcat::Client::ApiClient;

use base "Class::Data::Inheritable";

__PACKAGE__->mk_classdata( 'method_documentation' => {} );

sub new {
    my $class = shift;
    my $api_client;

    if ( $_[0] && ref $_[0] && ref $_[0] eq 'Smartcat::Client::ApiClient' ) {
        $api_client = $_[0];
    }
    else {
        $api_client = Smartcat::Client::ApiClient->new(@_);
    }

    bless { api_client => $api_client }, $class;

}

#
# glossary_get_glossaries
#
#
#
{
    my $params = {};
    __PACKAGE__->method_documentation->{'glossary_get_glossaries'} = {
        summary => '',
        params  => $params,
        returns => 'ARRAY[GlossaryModel]',
    };
}

# @return ARRAY[GlossaryModel]
#
sub glossary_get_glossaries {
    my ( $self, %args ) = @_;

    # parse inputs
    my $_resource_path = '/api/integration/v1/glossaries';

    my $_method       = 'GET';
    my $query_params  = {};
    my $header_params = {};
    my $form_params   = {};

    # 'Accept' and 'Content-Type' header
    my $_header_accept = $self->{api_client}
      ->select_header_accept( 'application/json', 'text/json' );
    if ($_header_accept) {
        $header_params->{'Accept'} = $_header_accept;
    }
    $header_params->{'Content-Type'} =
      $self->{api_client}->select_header_content_type();

    my $_body_data;

    # authentication setting, if any
    my $auth_settings = [qw()];

    # make the API Call
    my $response = $self->{api_client}->call_api(
        $_resource_path, $_method,    $query_params, $form_params,
        $header_params,  $_body_data, $auth_settings
    );
    if ( !$response ) {
        return;
    }
    my $_response_object =
      $self->{api_client}->deserialize( 'ARRAY[GlossaryModel]', $response );
    return $_response_object;
}

1;
