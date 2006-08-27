#!/usr/bin/perl -w
#############################################################################
## Name:        script/wx_xspp.pl
## Purpose:     XS++ preprocessor
## Author:      Mattia Barbon
## Modified by:
## Created:     01/03/2003
## RCS-ID:      $Id: wx_xspp.pl,v 1.1 2006/08/19 18:24:32 mbarbon Exp $
## Copyright:   (c) 2003-2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use FindBin;

use strict;
use lib "$FindBin::RealBin/../build";

=head1 NAME

XSP - XS++ preprocessor

=head1 DOCUMENTATION

See C<XSpp.pod> in the wxPerl distribution.

=cut

use Getopt::Long;

use Wx::XSP::Driver;

my @typemap_files;
GetOptions( 'typemap=s' => \@typemap_files );

my $driver = Wx::XSP::Driver->new
  ( typemaps   => \@typemap_files,
    file       => shift @ARGV,
    );
$driver->process;

exit 0;
