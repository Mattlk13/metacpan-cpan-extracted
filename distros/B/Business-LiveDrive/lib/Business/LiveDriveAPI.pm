package LiveDriveAPI;
# XXX - WARNING this has been altered. 
# XXX tns data types changed to string
# XXX default_ns set

# Generated by SOAP::Lite (v0.710.10) for Perl -- soaplite.com
# Copyright (C) 2000-2006 Paul Kulchenko, Byrne Reese
# -- generated at [Tue Nov 16 19:22:52 2010]
# -- generated from http://www.livedrive.com/ResellersService/ResellerAPI.asmx?WSDL
my %methods = (
GetUsers => {
    endpoint => 'http://www.livedrive.com/ResellersService/ResellerAPI.asmx',
    soapaction => 'http://www.livedrive.com/GetUsers',
    namespace => 'http://www.livedrive.com/',
    parameters => [
      SOAP::Data->new(name => 'apiKey', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'page', type => 's:int', attr => {}),
    ], # end parameters
  }, # end GetUsers
UpgradeUser => {
    endpoint => 'http://www.livedrive.com/ResellersService/ResellerAPI.asmx',
    soapaction => 'http://www.livedrive.com/UpgradeUser',
    namespace => 'http://www.livedrive.com/',
    parameters => [
      SOAP::Data->new(name => 'apiKey', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'userID', type => 's:int', attr => {}),
      SOAP::Data->new(name => 'capacity', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'cardVerificationValue', type => 's:string', attr => {}),
    ], # end parameters
  }, # end UpgradeUser
AddBackup => {
    endpoint => 'http://www.livedrive.com/ResellersService/ResellerAPI.asmx',
    soapaction => 'http://www.livedrive.com/AddBackup',
    namespace => 'http://www.livedrive.com/',
    parameters => [
      SOAP::Data->new(name => 'apiKey', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'userID', type => 's:int', attr => {}),
    ], # end parameters
  }, # end AddBackup
UpdateUser => {
    endpoint => 'http://www.livedrive.com/ResellersService/ResellerAPI.asmx',
    soapaction => 'http://www.livedrive.com/UpdateUser',
    namespace => 'http://www.livedrive.com/',
    parameters => [
      SOAP::Data->new(name => 'apiKey', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'userID', type => 's:int', attr => {}),
      SOAP::Data->new(name => 'firstName', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'lastName', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'email', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'confirmPassword', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'subDomain', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'isSharing', type => 's:boolean', attr => {}),
      SOAP::Data->new(name => 'hasWebApps', type => 's:boolean', attr => {}),
    ], # end parameters
  }, # end UpdateUser
AddUserWithLimit => {
    endpoint => 'http://www.livedrive.com/ResellersService/ResellerAPI.asmx',
    soapaction => 'http://www.livedrive.com/AddUserWithLimit',
    namespace => 'http://www.livedrive.com/',
    parameters => [
      SOAP::Data->new(name => 'apiKey', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'email', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'confirmPassword', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'subDomain', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'BriefcaseCapacity', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'BackupCapacity', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'isSharing', type => 's:boolean', attr => {}),
      SOAP::Data->new(name => 'hasWebApps', type => 's:boolean', attr => {}),
      SOAP::Data->new(name => 'firstName', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'lastName', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'cardVerificationValue', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'productType', type => 's:string', attr => {}),
    ], # end parameters
  }, # end AddUserWithLimit
AddUser => {
    endpoint => 'http://www.livedrive.com/ResellersService/ResellerAPI.asmx',
    soapaction => 'http://www.livedrive.com/AddUser',
    namespace => 'http://www.livedrive.com/',
    parameters => [
      SOAP::Data->new(name => 'apiKey', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'email', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'confirmPassword', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'subDomain', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'capacity', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'isSharing', type => 's:boolean', attr => {}),
      SOAP::Data->new(name => 'hasWebApps', type => 's:boolean', attr => {}),
      SOAP::Data->new(name => 'firstName', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'lastName', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'cardVerificationValue', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'productType', type => 's:string', attr => {}),
    ], # end parameters
  }, # end AddUser
AddBackupWithLimit => {
    endpoint => 'http://www.livedrive.com/ResellersService/ResellerAPI.asmx',
    soapaction => 'http://www.livedrive.com/AddBackupWithLimit',
    namespace => 'http://www.livedrive.com/',
    parameters => [
      SOAP::Data->new(name => 'apiKey', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'userID', type => 's:int', attr => {}),
      SOAP::Data->new(name => 'capacity', type => 's:string', attr => {}),
    ], # end parameters
  }, # end AddBackupWithLimit
GetUser => {
    endpoint => 'http://www.livedrive.com/ResellersService/ResellerAPI.asmx',
    soapaction => 'http://www.livedrive.com/GetUser',
    namespace => 'http://www.livedrive.com/',
    parameters => [
      SOAP::Data->new(name => 'apiKey', type => 's:string', attr => {}),
      SOAP::Data->new(name => 'userID', type => 's:int', attr => {}),
    ], # end parameters
  }, # end GetUser
); # end my %methods

use SOAP::Lite;
use Exporter;
use Carp ();

use vars qw(@ISA $AUTOLOAD @EXPORT_OK %EXPORT_TAGS);
@ISA = qw(Exporter SOAP::Lite);
@EXPORT_OK = (keys %methods);
%EXPORT_TAGS = ('all' => [@EXPORT_OK]);

sub _call {
    my ($self, $method) = (shift, shift);
    my $name = UNIVERSAL::isa($method => 'SOAP::Data') ? $method->name : $method;
    my %method = %{$methods{$name}};
    $self->proxy($method{endpoint} || Carp::croak "No server address (proxy) specified")
        unless $self->proxy;
    my @templates = @{$method{parameters}};
    my @parameters = ();
    foreach my $param (@_) {
        if (@templates) {
            my $template = shift @templates;
            my ($prefix,$typename) = SOAP::Utils::splitqname($template->type);
            my $method = 'as_'.$typename;
            # TODO - if can('as_'.$typename) {...}
            my $result = $self->serializer->$method($param, $template->name, $template->type, $template->attr);
            push(@parameters, $template->value($result->[2]));
        }
        else {
            push(@parameters, $param);
        }
    }

    $self->endpoint($method{endpoint})
       ->ns($method{namespace})
       ->on_action(sub{qq!"$method{soapaction}"!});

  $self->default_ns('http://www.livedrive.com/');

  $self->serializer->register_ns("http://microsoft.com/wsdl/mime/textMatching/","tm");
  $self->serializer->register_ns("http://schemas.xmlsoap.org/wsdl/soap12/","soap12");
  $self->serializer->register_ns("http://schemas.xmlsoap.org/wsdl/mime/","mime");
  $self->serializer->register_ns("http://www.w3.org/2001/XMLSchema","s");
  # $self->serializer->register_ns("http://schemas.xmlsoap.org/wsdl/soap/","soap");
   $self->serializer->register_ns("http://schemas.xmlsoap.org/wsdl/","wsdl");
   $self->serializer->register_ns("http://schemas.xmlsoap.org/soap/encoding/","soapenc");
  $self->serializer->register_ns("http://schemas.xmlsoap.org/wsdl/http/","http");

  $self->serializer->register_ns("http://www.livedrive.com/","tns");

    my $som = $self->SUPER::call($method => @parameters);
    if ($self->want_som) {
        return $som;
    }
    UNIVERSAL::isa($som => 'SOAP::SOM') ? wantarray ? $som->paramsall : $som->result : $som;
}

sub BEGIN {
    no strict 'refs';
    for my $method (qw(want_som)) {
        my $field = '_' . $method;
        *$method = sub {
            my $self = shift->new;
            @_ ? ($self->{$field} = shift, return $self) : return $self->{$field};
        }
    }
}
no strict 'refs';
for my $method (@EXPORT_OK) {
    my %method = %{$methods{$method}};
    *$method = sub {
        my $self = UNIVERSAL::isa($_[0] => __PACKAGE__)
            ? ref $_[0]
                ? shift # OBJECT
                # CLASS, either get self or create new and assign to self
                : (shift->self || __PACKAGE__->self(__PACKAGE__->new))
            # function call, either get self or create new and assign to self
            : (__PACKAGE__->self || __PACKAGE__->self(__PACKAGE__->new));
        $self->_call($method, @_);
    }
}

sub AUTOLOAD {
    my $method = substr($AUTOLOAD, rindex($AUTOLOAD, '::') + 2);
    return if $method eq 'DESTROY' || $method eq 'want_som';
    die "Unrecognized method '$method'. List of available method(s): @EXPORT_OK\n";
}

1;
