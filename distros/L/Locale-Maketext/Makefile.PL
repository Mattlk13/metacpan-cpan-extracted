require 5.004;
use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Locale::Maketext',
    VERSION_FROM  => 'lib/Locale/Maketext.pm',
    ABSTRACT_FROM => 'lib/Locale/Maketext.pod',
    PREREQ_PM     => {
        'I18N::LangTags'         => 0.31,
        'I18N::LangTags::Detect' => 0,
        'Test::More'             => 0,
        'parent'                 => 0,      # For testing t/30_eval_dollar_at.t
    },
    dist => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    ( $ExtUtils::MakeMaker::VERSION >= 6.3002 ? ( 'LICENSE' => 'perl', ) : () ),
    ( $] < 5.008 && $] > 5.011 ) ? () : ( INSTALLDIRS => 'perl' ),

    # If under a version with Maketext in core, overwrite that core file.
    META_MERGE => {
        resources => {
            license     => 'http://dev.perl.org/licenses/',
            bugtracker  => 'https://github.com/perl/perl5/issues',
            repository  => 'https://github.com/Perl/perl5/tree/blead/dist/Locale-Maketext',
            MailingList => 'http://lists.perl.org/list/perl5-porters.html',
        },
    },
);

sub MY::postamble {
    return <<'MAKE_FRAG';
.PHONY: tags critic

tags:
	ctags -f tags --recurse --totals \
		--exclude=blib \
		--exclude=.svn \
		--exclude='*~' \
		--languages=Perl --langmap=Perl:+.t \

critic:
	perlcritic -1 -q -profile perlcriticrc -statistics lib/ t/

MAKE_FRAG
}
