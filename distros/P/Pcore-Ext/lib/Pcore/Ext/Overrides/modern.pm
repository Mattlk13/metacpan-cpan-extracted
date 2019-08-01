package Pcore::Ext::Overrides::modern;

use Pcore -l10n;
use Pcore::CDN::Static::FA qw[:ALL];

sub EXT_override_grid_menu_SortAsc : Override('Ext.grid.menu.SortAsc') {
    return { config => { text => l10n('Sort Ascending'), }, };
}

sub EXT_override_grid_menu_SortDesc : Override('Ext.grid.menu.SortDesc') {
    return { config => { text => l10n('Sort Descending'), }, };
}

sub EXT_override_panel_Collapser : Override('Ext.panel.Collapser') {
    return {
        config => {
            collapseToolText => { html => l10n('Collapse panel') },
            expandToolText   => { html => l10n('Expand panel') },
        },
    };
}

sub EXT_override_dataview_plugin_ListPaging : Override('Ext.dataview.plugin.ListPaging') {
    return {
        config => {
            loadMoreText      => l10n('LOAD MORE ...'),
            noMoreRecordsText => l10n('NO MORE RECORDS'),
        },
    };
}

sub EXT_override_grid_PagingToolbar : Override('Ext.grid.PagingToolbar') {
    return {
        config => {
            prevButton => {
                xtype   => 'button',
                iconCls => $FAS_ARROW_LEFT,
            },
            nextButton => {
                xtype   => 'button',
                iconCls => $FAS_ARROW_RIGHT,
            },
        },
    };
}

sub EXT_override_field_Display : Override('Ext.field.Display') {
    return {    #
        defaultBindProperty => 'value',
    };
}

sub EXT_override_grid_plugin_ViewOptions : Override('Ext.grid.plugin.ViewOptions') {
    return {
        onColumnAdd => func [ 'grid', 'column' ],
        <<'JS',
            var text = column.getText();

            if (Ext.isObject(text)) {
                column.setText('' + text);
            }

            this.callParent(arguments);
JS
    };
}

# ExtJS-6.7.0 - fix for overflow scroller for tab panel, thrown error, when last tab was chosen "can't get property isAnimating of undefined" for scrollable.translatable.isAnimating
sub EXT_override_layout_Box : Override('Ext.layout.Box') {
    return {
        ensureVisible => func [ 'item', 'options' ],
        <<'JS',
            var container = this.getContainer(),
                scrollable = container.getScrollable(),
                item1 = item,
                options1 = options;

            if (!item1.isWidget) {
                options1 = item1;
                item1 = options1.item1;
            }

            if ( options1 && !isNaN(options1.offset) ) {
                item1 = this.getItemByOffset(options1.offset);
            }

            if ( this._currentEnsureVisibleItem === item1 && ( !scrollable.translatable || scrollable.translatable.isAnimating ) ) {
                return;
            }

            this.callParent(arguments);
JS
    };
}

1;
__END__
=pod

=encoding utf8

=head1 NAME

Pcore::Ext::Overrides::modern

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head1 METHODS

=head1 SEE ALSO

=cut
