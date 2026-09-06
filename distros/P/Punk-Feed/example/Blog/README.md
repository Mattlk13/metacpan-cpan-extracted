# A Punk blog with feeds

The example application for [Punk::Feed](https://metacpan.org/pod/Punk::Plugin::Feed).
Generated with `punk new Blog` and then given two feeds.

```
plackup app.psgi          # or: hyperman app.psgi
prove -l t/
```

Then:

| URL | |
|---|---|
| <http://localhost:5000/> | the posts, with autodiscovery tags in the head |
| <http://localhost:5000/feed.xml> | Atom 1.0 |
| <http://localhost:5000/feed.rss> | RSS 2.0 |
| <http://localhost:5000/feed/releases.xml> | a second, named feed |

`app.psgi` and `t/01-basic.t` add the distribution's `blib` to `@INC` so the
demo runs before `Punk::Feed` is installed. Drop those lines once it is.

## What to look at

**The sections are controller methods.** `feed 'Web::Feed#posts';` in
`lib/Blog.pm` takes a `'Controller#method'` target exactly as `get` does, and
the section itself lives in `lib/Blog/Controller/Web/Feed.pm`. A section that
reads rows is controller work. A closure works too, and is the right shape for
something too small to earn a method.

A section takes no context. It runs at `to_app` and again when the TTL has
passed, not per request, so there is no `$c` to hand it.

**The origin is configuration.** `config/punk.yml` declares
`host: https://blog.example.com`, and every URL in both documents is built on
it. The request's `Host` header is never consulted: it would let
`Host: evil.example` produce a feed naming that host for every item, and every
reader that fetched it would keep it for as long as they stayed subscribed.
That is why the URLs say `blog.example.com` even though you are reading this on
localhost.

**Autodiscovery comes from `$c->feed_links`.** The `<link rel="alternate">`
tags in the page head are generated, not typed into the layout - which is where
they go stale the first time `path` changes. The controller passes the value
through to the template; see `_page` in `Web/Root.pm`.

**Escaping.** The second post's title contains an ampersand. It reaches both
documents as `&amp;`, because one bare `&` makes a feed not well-formed and a
reader rejects the whole thing rather than the offending entry.

**Two dates, one format that can say so.** That same post was edited after
publication, so Atom carries `<updated>` and `<published>` separately. RSS has
one date element and shows only the publication date - one of the things that
format cannot express.

**Conditional GET.** A reader asks for this URL every few minutes for years, so
every response carries an `ETag` and a `Last-Modified`:

```
curl -sD- -o/dev/null http://localhost:5000/feed.xml
curl -sD- -o/dev/null -H 'If-None-Match: "<the etag>"' http://localhost:5000/feed.xml
```

The second is a `304` with no body.

**The feed timestamp is the newest entry's date, never now.** A rebuild that
found nothing new produces the same bytes as the one before it - otherwise
every reader would record a change on every TTL. RSS spells that element
`<lastBuildDate>`, and the name is the trap.
