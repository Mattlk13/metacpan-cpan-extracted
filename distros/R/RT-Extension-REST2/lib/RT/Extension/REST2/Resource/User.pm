package RT::Extension::REST2::Resource::User;
use strict;
use warnings;

use Moose;
use namespace::autoclean;

extends 'RT::Extension::REST2::Resource::Record';
with (
    'RT::Extension::REST2::Resource::Record::Readable',
    'RT::Extension::REST2::Resource::Record::DeletableByDisabling',
    'RT::Extension::REST2::Resource::Record::Writable',
    'RT::Extension::REST2::Resource::Record::Hypermedia'
        => { -alias => { hypermedia_links => '_default_hypermedia_links' } },
);

sub dispatch_rules {
    Path::Dispatcher::Rule::Regex->new(
        regex => qr{^/user/?$},
        block => sub { { record_class => 'RT::User' } },
    ),
    Path::Dispatcher::Rule::Regex->new(
        regex => qr{^/user/(\d+)/?$},
        block => sub { { record_class => 'RT::User', record_id => shift->pos(1) } },
    ),
    Path::Dispatcher::Rule::Regex->new(
        regex => qr{^/user/([^/]+)/?$},
        block => sub {
            my ($match, $req) = @_;
            my $user = RT::User->new($req->env->{"rt.current_user"});
            $user->Load($match->pos(1));
            return { record => $user };
        },
    ),
}

around 'serialize' => sub {
    my $orig = shift;
    my $self = shift;
    my $data = $self->$orig(@_);
    $data->{Privileged} = $self->record->Privileged ? 1 : 0;
    $data->{Disabled}   = $self->record->PrincipalObj->Disabled;
    return $data;
};

sub forbidden {
    my $self = shift;
    return 0 if not $self->record->id;
    return 0 if $self->record->id == $self->current_user->id;
    return 0 if $self->record->CurrentUserHasRight("AdminUsers");
    return 1;
}

sub hypermedia_links {
    my $self = shift;
    my $links = $self->_default_hypermedia_links(@_);
    push @$links, $self->_transaction_history_link;
    return $links;
}

__PACKAGE__->meta->make_immutable;

1;
