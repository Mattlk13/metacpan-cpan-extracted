# Mojopaste - Pastebin application

Mojopaste is a pastebin application. There's about one million of these out
there, but if you have the need to run something internally at work or you
just fancy having your own pastebin, this is your application.

# Text and code

The standard version of [App::mojopaste](https://metacpan.org/pod/App::mojopaste) can take normal text as input,
store it as a text file on the server and render the content as either
plain text or prettified using [Google prettify](https://code.google.com/p/google-code-prettify/).
(Note: Maybe another prettifier will be used in future versions)

# Charts

In addition to just supporting text, this application can also make charts
from the input data. To turn this feature on, you need to specify
"enable\_charts" in the config or set the `PASTE_ENABLE_CHARTS`
environment variable:

    $ PASTE_ENABLE_CHARTS=1 script/mojopaste daemon;

The input chart data must be valid CSV:

CSV data is similar to ["Just data"](#just-data) above, except the first line is used as
"xkey,ykey1,ykey2,...". Example:

    # Can have comments in CSV input as well
    x,a,b
    2015-02-04 15:03,120,90
    2015-03-14,75,65
    2015-04,100,40

CSV input data require [Text::CSV](https://metacpan.org/pod/Text::CSV) to be installed.

# Embedding

A paste can be embedded in other pages using the query param "embed". Examples:

- [http://p.thorsen.pm/mojopastedemo.txt](http://p.thorsen.pm/mojopastedemo.txt)
  Get the raw data.
- [http://p.thorsen.pm/mojopastedemo?embed=text](http://p.thorsen.pm/mojopastedemo?embed=text)
  Show the paste without any margin/padding and no menu.
- [http://p.thorsen.pm/mojopastedemo/chart?embed=graph](http://p.thorsen.pm/mojopastedemo/chart?embed=graph)
  Show only the graph data.
- [http://p.thorsen.pm/mojopastedemo/chart?embed=graph,heading,description](http://p.thorsen.pm/mojopastedemo/chart?embed=graph,heading,description)
  Show the graph data, heading and description, but no menus.

# Demo

You can try mojopaste here: [http://p.thorsen.pm](http://p.thorsen.pm).

# Installation

Install system wide with cpanm:

    $ cpanm --sudo App::mojopaste

# Docker run

It is possible to install [mojopaste](https://hub.docker.com/r/jhthorsen/mojopaste)
using Docker:

    $ mkdir /var/lib/mojopaste
    $ docker run -d --restart always --name mojopaste \
      -v /var/lib/mojopaste:/app/data -p 3000:8080 jhthorsen/mojopaste

# Synopsis

- Simple single process daemon

        $ mojopaste daemon --listen http://*:8080

- Save paste to custom dir

        $ PASTE_DIR=/path/to/paste/dir mojopaste daemon --listen http://*:8080

- Using the UNIX optimized, preforking hypnotoad web server

        $ MOJO_CONFIG=/path/to/mojopaste.conf hypnotoad $(which mojopaste)

    Example mojopaste.conf:

        {
          paste_dir     => '/path/to/paste/dir',
          enable_charts => 1, # default is 0
          hypnotoad => {
            listen => ['http://*:8080'],
          },
        }

    "enable\_charts" is for adding a button which can make a chart of the input
    data using [morris.js](http://morrisjs.github.io/morris.js)

    Check out [Mojo::Server::Hypnotoad](https://metacpan.org/pod/Mojo::Server::Hypnotoad) for more hypnotoad options.
