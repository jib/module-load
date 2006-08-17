use ExtUtils::MakeMaker;
use strict;

WriteMakefile (
    NAME            => 'Module::Load',
    VERSION_FROM    => 'lib/Module/Load.pm', # finds $VERSION
    dist            => { COMPRESS => 'gzip -9f', SUFFIX => 'gz' },
    PREREQ_PM       => { 'Test::More' => 0 },
    AUTHOR          => 'Jos Boumans <kane[at]cpan.org>',
	ABSTRACT        => 'Load modules in a DWIM style'
);      
