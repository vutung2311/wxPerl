#!/usr/bin/perl -w
#############################################################################
## Name:        script/fix_alien_path.pl
## Purpose:     Substitute Alien::wxWidgets path in modules
## Author:      Mattia Barbon
## Modified by:
## Created:     15/08/2005
## RCS-ID:      $Id: fix_alien_path.pl,v 1.1.2.3 2005/08/17 19:27:46 mbarbon Exp $
## Copyright:   (c) 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use blib; # to pick the correct 'Wx::build::Options'
use Alien::wxWidgets 0.03 ();
use Wx::build::Options;
use Fatal qw(open close unlink);
use Config;

# we do not care about the options, just that Alien::wxWidgets
# initialized with the correct key
Wx::build::Options->get_makemaker_options( 'saved' );

my( $from, $to ) = @ARGV;
my $path = Alien::wxWidgets->shared_library_path;

unlink $to if -f $to;
open my $in, "< $from";
open my $out, "> $to";

while( <$in> ) {
    s/XXXALIENXXX/$path$Config{path_sep}/g;
    print $out $_;
}

close $in;
close $out;

exit 0;
