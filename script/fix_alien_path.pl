#!/usr/bin/perl -w
#############################################################################
## Name:        script/fix_alien_path.pl
## Purpose:     Substitute Alien::wxWidgets path in modules
## Author:      Mattia Barbon
## Modified by:
## Created:     15/08/2005
## RCS-ID:      $Id: fix_alien_path.pl,v 1.1.2.1 2005/08/15 16:17:15 mbarbon Exp $
## Copyright:   (c) 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use Alien::wxWidgets;
use Fatal qw(open close unlink);
use Config;

my( $from, $to ) = @ARGV;
my $path = $INC{'Alien/wxWidgets.pm'};

$path =~ s{\.pm$}{/lib};

unlink $to;
open my $in, "< $from";
open my $out, "> $to";

while( <$in> ) {
    s/XXXALIENXXX/$path$Config{path_sep}/g;
    print $out $_;
}

close $in;
close $out;

exit 0;
