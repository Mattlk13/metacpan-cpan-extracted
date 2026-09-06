package Blog::Controller::Web::Feed;

use Punk::Controller;
use Blog::Posts;

our $VERSION = '0.01';

# A feed section reads rows and shapes them, which is controller work - so it
# lives here rather than as a closure in the routing table. `feed` takes a
# 'Controller#method' target exactly as `get` does.
#
# A section takes no context: it runs at to_app and again when the TTL has
# passed, not per request. There is no $c to hand it.

sub posts {
    return map +{
        loc       => "/posts/$_->{slug}",
        title     => $_->{title},
        updated   => $_->{updated},
        published => $_->{published},
        summary   => $_->{excerpt},
        content   => $_->{body},
        category  => $_->{tags},
        # A URL is a fine default id; this spells out the alternative, because
        # a post whose URL changes is a post every subscriber sees twice.
        id        => "tag:blog.example,2026:post/$_->{slug}",
    }, Blog::Posts->all;
}

sub releases {
    return map +{
        loc     => "/posts/$_->{slug}",
        title   => $_->{title},
        updated => $_->{updated},
        summary => $_->{excerpt},
    }, Blog::Posts->releases;
}

1;

__END__
