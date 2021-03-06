use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.007004
use Test::Spelling 0.12;
use Pod::Wordlist;


add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( bin lib ) );
__DATA__
BoundsFromCairoImageSurface
Cacheable
Cairo
CairoImageSurface
CairoRenderable
CairoRenderableFromPNG
Devel
Document
Format
ImageSurface
Incunabula
PNG
Page
PageNumber
Project
Renard
Renderable
RenderableDocumentModel
RenderablePageModel
RenderedFromPNG
Role
TestHelper
Types
ZoomLevel
lib
