# NAME

Mojolicious::Plugin::Component - Module-based Component Rendering

# ABSTRACT

Module-based Component Rendering Plugin

# SYNOPSIS

    package App;

    use Mojo::Base 'Mojolicious';

    package App::Component::Image;

    use Mojo::Base 'Mojolicious::Component';

    has alt => 'random';
    has height => 126;
    has width => 145;
    has src => '/random.gif';

    1;

    # __DATA__
    #
    # @@ component
    #
    # <img
    #   alt="<%= $component->alt %>"
    #   height="<%= $component->height %>"
    #   src="<%= $component->src %>"
    #   width="<%= $component->width %>"
    # />

    package main;

    my $app = App->new;

    my $component = $app->plugin('component');

    my $image = $app->component->use('image');

    my $rendered = $image->render;

# DESCRIPTION

This package provides [Mojolicious](https://metacpan.org/pod/Mojolicious) module-based component rendering plugin.

# INHERITS

This package inherits behaviors from:

[Mojolicious::Plugin](https://metacpan.org/pod/Mojolicious::Plugin)

# METHODS

This package implements the following methods:

## register

    register(InstanceOf["Mojolicious"] $app, Maybe[HashRef] $config) : Object

The register method registers one or more component builders in the
[Mojolicious](https://metacpan.org/pod/Mojolicious) application. The configuration information can be provided when
registering the plugin by calling [plugin](https://metacpan.org/pod/plugin) during setup, or by specifying the
data in the application configuration under the key `component`. By default,
if no configuration information is provided the plugin will register a builder
labeled `use` which will load components under the application's `Component`
namespace.

- register example #1

        package main;

        use Mojolicious::Plugin::Component;

        my $app = Mojolicious->new;

        my $component = Mojolicious::Plugin::Component->new;

        $component = $component->register($app);

- register example #2

        package main;

        use Mojolicious::Plugin::Component;

        my $app = Mojolicious->new;

        my $component = Mojolicious::Plugin::Component->new;

        $component = $component->register($app, {
          v1 => 'App::V1::Component',
          v2 => 'App::V2::Component',
        });

        # my $v1 = $app->component->v1('image');
        # my $v2 = $app->component->v2('image');

- register example #3

        package main;

        use Mojolicious::Plugin::Component;

        my $app = Mojolicious->new;

        my $component = Mojolicious::Plugin::Component->new;

        $component = $component->register($app, {
          v1 => 'App::V1::Component',
          v2 => 'App::V2::Component',
        });

        # my $v1 = $app->component->v1('image' => (
        #   src => '/random-v1.gif',
        # ));

        # my $v2 = $app->component->v2('image' => (
        #   src => '/random-v2.gif',
        # ));

# AUTHOR

Al Newkirk, `awncorp@cpan.org`

# LICENSE

Copyright (C) 2011-2019, Al Newkirk, et al.

This is free software; you can redistribute it and/or modify it under the terms
of the The Apache License, Version 2.0, as elucidated in the ["license
file"](https://github.com/cpanery/mojolicious-plugin-component/blob/master/LICENSE).

# PROJECT

[Wiki](https://github.com/cpanery/mojolicious-plugin-component/wiki)

[Project](https://github.com/cpanery/mojolicious-plugin-component)

[Initiatives](https://github.com/cpanery/mojolicious-plugin-component/projects)

[Milestones](https://github.com/cpanery/mojolicious-plugin-component/milestones)

[Contributing](https://github.com/cpanery/mojolicious-plugin-component/blob/master/CONTRIBUTE.md)

[Issues](https://github.com/cpanery/mojolicious-plugin-component/issues)
