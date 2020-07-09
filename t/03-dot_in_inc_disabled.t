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
use Module::Load dot_in_inc => 0;

{
    open my $fh, '>', 'Incdot.pm' or die $!;
    print $fh "package Incdot; 1;";
    close $fh;

    is +(grep { $_ eq '.' } @INC), 0, "local dir not in \@INC after loading Module::Load";

    my $ok = eval { load 'Incdot.pm'; 1; };
    is $ok, undef, "load() doesn't load a file in local dir with use_inc_dot false";

    my $ok = eval { load Incdot; 1; };
    is $ok, undef, "load() doesn't load a module in local dir with use_inc_dot false";

    unlink 'Incdot.pm' or die $!;
    is -f 'Incdot.pm', undef, "sample module file removed ok";
}

done_testing();
