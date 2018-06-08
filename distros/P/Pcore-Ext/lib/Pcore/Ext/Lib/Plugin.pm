package Pcore::Ext::Lib::Plugin;

use Pcore -l10n;

sub EXT_swipe_tab($ext) : Extend('Ext.plugin.Abstract') : Type('plugin') {
    return {
        config => {
            cmp             => undef,
            allowOverflow   => \1,
            allowDirections => [ 'left', 'right', 'up', 'down' ]
        },

        init => $ext->js_func(
            ['cmp'], <<'JS'
                this.updateCmp(cmp);
JS
        ),

        updateCmp => $ext->js_func(
            [ 'newCmp', 'oldCmp' ], <<'JS'
                if (newCmp) {
                    this.setCmp(newCmp);

                    newCmp.element.on('swipe', this.onSwipe, this);
                }

                if (oldCmp) {
                    oldCmp.element.un('swipe', this.onSwipe);
                }
JS
        ),

        onSwipe => $ext->js_func(
            ['e'], <<'JS'
                if (this.getAllowDirections().indexOf(e.direction) < 0) {
                    return;
                }

                var cmp           = this.getCmp(),
                    allowOverflow = this.getAllowOverflow(),
                    direction     = e.direction,
                    activeItem    = cmp.getActiveItem(),
                    innerItems    = cmp.getInnerItems(),
                    numIdx        = innerItems.length - 1,
                    idx           = Ext.Array.indexOf(innerItems, activeItem),
                    newIdx        = idx + (direction === 'left' ? 1 : -1),
                    newItem;

                if (newIdx < 0) {
                    if (allowOverflow) {
                        newItem = innerItems[numIdx];
                    }
                } else if (newIdx > numIdx) {
                    if (allowOverflow) {
                        newItem = innerItems[0];
                    }
                } else {
                    newItem = innerItems[newIdx];
                }

                if (newItem) {
                    cmp.setActiveItem(newItem);
                }
JS
        ),
    };
}

1;
__END__
=pod

=encoding utf8

=head1 NAME

Pcore::Ext::Lib::Plugin

=head1 SYNOPSIS

    # swipe tab plugin
    plugins => {
        $ext->{type}->{'/Pcore/Ext/Lib/Plugin/swipe_tab'} => {
            allowOverflow   => \0,
            allowDirections => [ 'left', 'right' ],
        },
    },

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head1 METHODS

=head1 SEE ALSO

=cut
