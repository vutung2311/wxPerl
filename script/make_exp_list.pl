#!/usr/bin/perl -w
#############################################################################
## Name:        make_exp_list.pl
## Purpose:     builds lib/Wx/_Exp.pm (export lists for Wx and Wx::Event)
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: make_exp_list.pl,v 1.14 2003/05/04 17:32:14 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#
# @EXPORT_OK and %EXPORT_TAGS for Wx.pm (constants in Constant.xs)
#

my $ext = shift @ARGV;

my $parser;
my %packages;
my $tag;
my $package;

sub add_to_exports {
  my( $values, $tags ) = @_;

  foreach my $i ( split '\s+', $values ) {
    next if $i =~ /^\s*$/;

    foreach my $j ( split '\s+', $tags ) {
      next if $_ =~ /^\s*$/;

      push @{ $packages{$package}{tags}{$j} }, $i;
    }

    push @{ $packages{$package}{exp_ok} }, $i;
  }
}

foreach my $i ( @ARGV ) {
  open IN, '< ' . $i or die "unable to open '$i'";
  $tag = '';
  $package = '';
  $parser = undef;

  while( <IN> ) {
    m/^\W+?\!(\w+):\s*(.*)$/ && do {
      my( $t, $v ) = ( $1, $2 );

      if( $t eq 'parser' ) { $parser = eval "$v"; die if $@ }
      if( $t eq 'package' ) { $package = $v }
      if( $t eq 'tag' ) { $tag = $v }
      if( $t eq 'export' ) { add_to_exports( $v, $tag ); next }
      next;
    };
    next unless $parser;

    my @values = $parser->( $_ );
    ( defined( $values[0] ) && length( $values[0] ) ) || next;
    $values[1] ||= '';

    add_to_exports( $values[0], "$values[1] $tag" );
  }
}

close IN;

#
# write export file
#

open OUT, '> '. $ext || die "unable to open file '$ext'";

binmode OUT; # Perl 5.004 on Unix complains for CR

print OUT <<EOT;
#############################################################################
## Name:        lib/Wx/Wx_Exp.pm
## Purpose:     export lists (AUTOGENERATED, DO NOT EDIT)
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000-2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################
EOT

foreach my $package ( sort keys %packages ) {
print OUT <<EOT;

package ${package};

push \@EXPORT_OK, qw(@{$packages{$package}{exp_ok}});

\$EXPORT_TAGS{'everything'} = \\\@EXPORT_OK;

EOT

  foreach my $tag ( sort keys %{ $packages{$package}{tags} } ) {
    next unless length $tag;
    print OUT <<EOT;
\$EXPORT_TAGS{'$tag'} = [ qw(@{ $packages{$package}{tags}{$tag} }) ];
EOT
  }
}

print OUT <<EOT;
1;

# Local variables: #
# mode: cperl #
# End: #
EOT

# Local variables: #
# mode: cperl #
# End: #

