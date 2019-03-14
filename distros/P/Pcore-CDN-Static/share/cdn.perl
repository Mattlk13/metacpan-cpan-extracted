{
    # pcore-api
    pcore_api => sub ( $cdn, $native, $args ) {
        if (wantarray) {
            return $cdn->get_script_tag( $cdn->("/static/pcore/api.js") );
        }
        else {
            return $cdn->("/static/pcore");
        }
    },

    # FontAwesome
    fa5 => sub ( $cdn, $native, $args ) {
        my $ver = version->parse( $args->{ver} // v5.7.2 );

        state $native_prefix = 'https://use.fontawesome.com/releases';

        if (wantarray) {
            return $cdn->get_css_tag( $native ? "$native_prefix/$ver/css/all.css" : $cdn->("/static/fa/$ver/css/all.min.css") );
        }
        else {
            return $native ? "$native_prefix/$ver" : $cdn->("/static/fa/$ver");
        }
    },

    # jQuery3
    jquery3 => sub ( $cdn, $native, $args ) {
        my $ver = version->parse( $args->{ver} // v3.3.1 );

        state $native_prefix = 'https://ajax.googleapis.com/ajax/libs/jquery';

        if (wantarray) {
            return $cdn->get_script_tag( $native ? "$native_prefix/@{[ substr $ver, 1 ]}/jquery.min.js" : $cdn->("/static/jquery/$ver/jquery.min.js") );
        }
        else {
            return $native ? "$native_prefix/" . substr $ver, 1 : $cdn->("/static/jquery/$ver");
        }
    },

    # tinycolor, https://github.com/bgrins/TinyColor
    tinycolor1 => sub ( $cdn, $native, $args ) {
        my $ver = version->parse( $args->{ver} // v1.4.1 );

        if (wantarray) {
            return $cdn->get_script_tag( $cdn->("/static/tinycolor/$ver/tinycolor.js") );
        }
        else {
            return $cdn->("/static/tinycolor/$ver");
        }
    },

    # froala, https://www.froala.com/wysiwyg-editor
    froala2 => sub ( $cdn, $native, $args ) {
        my $ver = version->parse( $args->{ver} // v2.9.3 );

        if (wantarray) {
            my @res;

            push @res, $cdn->get_css_tag( $cdn->("/static/froala/$ver/css/froala_editor.pkgd.min.css") );
            push @res, $cdn->get_script_tag( $cdn->("/static/froala/$ver/js/froala_editor.pkgd.min.js") );

            return @res;
        }
        else {
            return $cdn->("/static/unitegallery/$ver");
        }
    },

    # unitegallery, https://unitegallery.net
    unitegallery1 => sub ( $cdn, $native, $args ) {
        my $ver = version->parse( $args->{ver} // v1.7.45 );

        if (wantarray) {
            my @res;

            push @res, $cdn->get_css_tag( $cdn->("/static/unitegallery/$ver/css/unite-gallery.css") );
            push @res, $cdn->get_script_tag( $cdn->("/static/unitegallery/$ver/js/unitegallery.min.js") );

            # theme
            # push @res, $cdn->get_css_tag( $cdn->("/static/unitegallery/$ver/themes/default/ug-theme-default.css") );
            # push @res, $cdn->get_script_tag( $cdn->("/static/unitegallery/$ver/themes/default/ug-theme-default.js") );

            return @res;
        }
        else {
            return $cdn->("/static/unitegallery/$ver");
        }
    },

    # amCharts4
    amcharts4 => sub ( $cdn, $native, $args ) {
        my $ver = version->parse( $args->{ver} // v4.2.2 );

        state $native_prefix = 'https://www.amcharts.com/lib/4';

        if (wantarray) {
            my @res;

            push @res, $cdn->get_script_tag( $native ? "$native_prefix/core.js"   : $cdn->("/static/amcharts/$ver/core.js") );
            push @res, $cdn->get_script_tag( $native ? "$native_prefix/charts.js" : $cdn->("/static/amcharts/$ver/charts.js") ) if $args->{charts};
            push @res, $cdn->get_script_tag( $native ? "$native_prefix/maps.js"   : $cdn->("/static/amcharts/$ver/maps.js") ) if $args->{maps};

            return @res;
        }
        else {
            return $native ? $native_prefix : $cdn->("/static/amcharts/$ver");
        }
    },

    # amCharts4 geodata
    amcharts4_geodata => sub ( $cdn, $native, $args ) {
        my $ver = version->parse( $args->{ver} // v4.1.4 );

        state $native_prefix = 'https://www.amcharts.com/lib/4/geodata';

        if (wantarray) {
            die q[Invalid usage of "amcharts4_geodata" resource];
        }
        else {
            return $native ? $native_prefix : $cdn->("/static/amcharts-geodata/$ver");
        }
    },

    # pdfjs
    pdfjs => sub ( $cdn, $native, $args ) {
        my $ver = version->parse( $args->{ver} // v2.1.266 );

        state $native_prefix = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js';

        if (wantarray) {
            my @res;

            push @res, $cdn->get_script_tag( $native ? "$native_prefix/@{[ substr $ver, 1 ]}/pdf.min.js" : $cdn->("/static/pdfjs/$ver/pdf.min.js") );

            return @res;
        }
        else {
            return $native ? "$native_prefix/" . substr $ver, 1 : $cdn->("/static/pdfjs/$ver");
        }
    },

    # ExtJS
    extjs6 => sub ( $cdn, $native, $args ) {
        my $ver = version->parse( $args->{ver} // v6.7.0 );

        if (wantarray) {
            my @res;

            my $debug = $args->{devel} ? '-debug' : $EMPTY;

            # framework
            if ( $args->{type} eq 'classic' ) {
                push @res, $cdn->get_script_tag( $cdn->("/static/extjs/$ver/ext-all$debug.js") );
            }
            else {
                push @res, $cdn->get_script_tag( $cdn->("/static/extjs/$ver/ext-modern-all$debug.js") );
            }

            # ux
            # push @res, $cdn->get_script_tag( $cdn->("/static/extjs/$ver/packages/ux/$framework/ux$debug.js") );

            # theme
            push @res, $cdn->get_css_tag( $cdn->("/static/extjs/$ver/$args->{type}/theme-$args->{theme}/resources/theme-$args->{theme}-all$debug.css") );
            push @res, $cdn->get_script_tag( $cdn->("/static/extjs/$ver/$args->{type}/theme-$args->{theme}/theme-$args->{theme}$debug.js") );

            # fashion, only for modern material theme
            push @res, $cdn->get_script_tag( $cdn->("/static/extjs/$ver/css-vars.js") );

            return @res;
        }
        else {
            return $cdn->("/static/extjs/$ver");
        }
    },
}
## -----SOURCE FILTER LOG BEGIN-----
##
## PerlCritic profile "pcore-config" policy violations:
## +------+----------------------+----------------------------------------------------------------------------------------------------------------+
## | Sev. | Lines                | Policy                                                                                                         |
## |======+======================+================================================================================================================|
## |    3 | 1                    | Modules::ProhibitExcessMainComplexity - Main code has high complexity score (37)                               |
## +------+----------------------+----------------------------------------------------------------------------------------------------------------+
##
## -----SOURCE FILTER LOG END-----
