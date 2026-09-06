package Blog::Controller::Web::Root;

use Punk::Controller;
use Blog::Posts;

our $VERSION = '0.01';

# feed_links is a helper on the context, and the layout needs it as a value, so
# it is passed with everything else a page renders. Doing it in one place per
# controller beats writing four attributes into the layout by hand, which is
# where the URL goes stale the first time `path` changes.
sub _page {
    my ($c, $template, $data) = @_;
    return $c->render($template, { feed_links => $c->feed_links, %$data });
}

sub index {
    my ($c) = @_;
    return _page($c, 'index', {
        title => 'A Punk Blog',
        posts => [ map +{
            %$_,
            url => $c->url_for('post', slug => $_->{slug}),
        }, Blog::Posts->all ],
    });
}

sub show {
    my ($c) = @_;
    my $post = Blog::Posts->find($c->param('slug'))
        or return $c->not_found;
    return _page($c, 'post', { title => $post->{title}, post => $post });
}

1;

__END__
