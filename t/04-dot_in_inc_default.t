BEGIN {
    if( $ENV{PERL_CORE} ) {
        chdir '../lib/Module/Load' if -d '../lib/Module/Load';
        unshift @INC, '../../..';
    }
}

BEGIN { chdir 't' if -d 't' }

use strict;
use lib qw[../lib to_load];

use Test::More;

BEGIN {
    @INC = grep { $_ ne '.' } @INC;
    is +(grep { $_ eq '.' } @INC), 0, "local dir not in \@INC prior to loading Module::Load";
}

use Module::Load;

{
    is +(grep { $_ eq '.' } @INC), 1, "local dir in \@INC after loading Module::Load";

    open my $fh, '>', 'Incdot.pm' or die $!;
    print $fh "package Incdot; 1;";
    close $fh;

    load 'Incdot.pm';

    my $ok = eval { load 'Incdot.pm'; 1; };
    is $ok, 1, "load() loads a file in local dir ok with no '.' in \@INC";

    $ok = eval { load Incdot; 1; };
    is $ok, 1, "load() loads a module in local dir ok with no '.' in \@INC";

    unlink 'Incdot.pm' or die $!;
    is -f 'Incdot.pm', undef, "sample module file removed ok";

}

done_testing();
