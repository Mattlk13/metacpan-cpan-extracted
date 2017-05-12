use warnings;
use strict;
use Test::More;

{
    package MyApp::Controller::Root;
    $INC{'MyApp/Controller/Root.pm'} = __FILE__;

    use Moose;
    use MooseX::MethodAttributes;

    extends 'Catalyst::Controller';

    sub root :Chained(/) PathPart('') CaptureArgs(0) {
      my ($self, $c) = @_;
    }

    sub top :Chained('root') Args(0) {
      my ($self, $c) = @_;
      Test::More::is $self->action_for('top'), 'top';
      Test::More::is $self->action_for('story/story'), 'story/story';
    }

    sub default : Path {

        my ($self, $c) = @_;
        $c->response->body("Ok");
    }

    MyApp::Controller::Root->config(namespace=>'');

    package MyApp::Controller::Story;
    $INC{'MyApp/Controller/Story.pm'} = __FILE__;

    use Moose;
    use MooseX::MethodAttributes;

    extends 'Catalyst::Controller';

    sub root :Chained(/root) PathPart('') CaptureArgs(0) {
      my ($self, $c) = @_;
    }

    sub story :Chained(root) Args(0) {
      my ($self, $c) = @_;

      Test::More::is $self->action_for('story'), 'story/story';
      Test::More::is $self->action_for('author/author'), 'story/author/author';
    }

    __PACKAGE__->meta->make_immutable;

    package MyApp::Controller::Story::Author;
    $INC{'MyApp/Controller/Story/Author.pm'} = __FILE__;

    use Moose;
    use MooseX::MethodAttributes;

    extends 'Catalyst::Controller';

    sub root :Chained(/story/root) PathPart('') CaptureArgs(0) {
      my ($self, $c) = @_;
    }

    sub author :Chained(root) Args(0) {
      my ($self, $c, $id) = @_;
      Test::More::is $self->action_for('author'), 'story/author/author';
      Test::More::is $self->action_for('../story'), 'story/story';
      Test::More::is $self->action_for('../../top'), 'top';
    }

    __PACKAGE__->meta->make_immutable;

    package MyApp;
    $INC{'MyApp.pm'} = __FILE__;

    use Catalyst;

    MyApp->setup;
}

use Catalyst::Test 'MyApp';

ok request '/top';
ok request '/story';
ok request '/author';
ok request '/double';
ok request '/double/file.ext';
ok request '/double/file..ext';


done_testing(13);

