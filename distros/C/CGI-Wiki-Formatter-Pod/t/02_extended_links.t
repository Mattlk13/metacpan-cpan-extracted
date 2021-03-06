use strict;
use Test::More;
use CGI::Wiki::Formatter::Pod;

eval { require CGI::Wiki::Formatter::UseMod; };

if ( $@ ) {
    plan skip_all =>"CGI::Wiki::Formatter::UseMod required to run these tests";
} else {
    plan tests => 3;

    my $formatter = CGI::Wiki::Formatter::Pod->new(
        usemod_extended_links => 1,
    );

    my $pod = "[[An Extended Link]]";
    my $html = $formatter->format($pod);
    like( $html, qr/<a href="wiki.cgi\?node=An%20Extended%20Link">/,
          "extended links work when required" );

    $pod = "[[An extended link]]";
    $html = $formatter->format($pod);
    like( $html, qr/<a href="wiki.cgi\?node=An%20Extended%20Link">/,
          "node names forced to ucfirst" );

    $pod = "This sentence contains [[a link]].";
    $html = $formatter->format($pod);
    like( $html, qr/This sentence contains\s+<a href/,
          "links inlined with no extraneous markup" );
}
