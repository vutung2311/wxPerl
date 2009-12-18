#!/usr/bin/perl -w
#############################################################################
## Name:        script/make_delayload.pl
## Purpose:     builds the list of classes for delayed module loading
## Author:      Mattia Barbon
## Modified by:
## Created:     07/12/2009
## RCS-ID:      $Id: make_exp_list.pl 2057 2007-06-18 23:03:00Z mbarbon $
## Copyright:   (c) 2009 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use warnings;

use File::Basename;

my( %packages, %constants );

foreach my $arg ( @ARGV ) {
    open my $in, '<', $arg or die "Unable to open $arg: $!";

    my $module;

    if( $arg =~ /\.pm$/ ) {
        while( <$in> ) {
            m/^\W+?\!(\w+):\s*(.*)$/ && do {
                my( $t, $v ) = ( $1, $2 );

                if( $t eq 'module' ) { $module = $v; $module =~ s/^Wx:://; }
                next;
            };
            next unless /^# BEGIN packages$/../^# END packages$/;
            next unless /^package\s+Wx::([a-zA-Z0-9:]+)/;

            $packages{$module}{$1} = 1;
        }
    } elsif( $arg =~ /\.cpp$/ ) {
        my $parser;

        while( <$in> ) {
            m/^\W+?\!(\w+):\s*(.*)$/ && do {
                my( $t, $v ) = ( $1, $2 );

                if( $t eq 'parser' ) { $parser = eval "$v"; die if $@ }
                if( $t eq 'module' ) { $module = $v; $module =~ s/^Wx:://; }
                next;
            };
            next unless $parser;

            my @values = $parser->( $_ );
            ( defined( $values[0] ) && length( $values[0] ) ) || next;

            $constants{$module}{$values[0]} = 1;
        }
    }
}

print <<EOT;
#include "cpp/helpers.h"
#include "cpp/constants.h"

EOT

foreach my $module ( keys %packages ) {
    print "DECLARE_MODULE( $module );\n";
}

foreach my $module ( keys %constants ) {
    ( my $func_name = "delay_${module}_constants" ) =~ s{::}{_}g;

    print <<EOT;

double $func_name( const char* name, int arg )
{
    dTHX;

    if(
EOT

    foreach my $constant ( keys %{$constants{$module}} ) {
        print <<EOT
        strEQ( name, "$constant" ) ||
EOT
    }

    print <<EOT;
        0 )
    {
        load_module( 0, newSVpv( "Wx::${module}", 0 ), NULL, NULL );

        // TODO need to define a sane interface
        errno = EAGAIN;
    }

    WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants ${func_name}_module( &${func_name} );

EOT
}

print "\n";
print "void DelayLoadModules(pTHX)\n";
print "{\n";

foreach my $module ( keys %packages ) {
    foreach my $package ( keys %{$packages{$module}} ) {
        print "    LOAD_MODULE( $module, $package );\n";
    }
}

print "}\n";
