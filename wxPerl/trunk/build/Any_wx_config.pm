############################################################################
## Name:        Any_wx_config.pm
## Purpose:     build helper for wx-config
## Author:      Mattia Barbon
## Modified by:
## Created:     14/ 3/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Any_wx_config;

use strict;
use Config;
use wxMMUtils;
use base 'Any_OS';

#
# wx-config-like
#
sub wx_config {
  my $options = join ' ', map { "--$_" } @_;

  my $t = qx(wx-config $options);
  chomp $t;
  return $t;
}

#
# takes parameters from the wx-config script
#
sub cc_is_GNU {
  my $cc = shift;
  my $pipe = MM->catfile( top_dir(), 'script', 'pipe.pl' );

  return 1 if $cc =~ m/gcc|g\+\+/i;
  return 1 if qx($^X $pipe $cc -v) =~ m/gcc|g\+\+|\sgnu\s/i;
  return;
}

sub ld_is_GNU {
  my $ld = shift;
  my $pipe = MM->catfile( top_dir(), 'script', 'pipe.pl' );

  return 1 if $ld =~ m/gcc|g\+\+/i;
  return 1 if qx($^X $pipe $ld -v) =~ m/gcc|g\+\+|\sgnu\s/i;

  return;
}

sub configure {
  my( $cccflags, $libs );

  my( %config ) =
    ( LIBS => $wxConfig::extra_libs . ' ',
      CCFLAGS => $wxConfig::extra_cflags . ' -I. ',
      ( building_extension() ?
        ( INC => ' -I' . top_dir() . ' ',
          DEFINE => ' -DWXPL_EXT ',
          LDFROM => ' $(OBJECT) ',
        ) : (),
      ),
    );

  if( cc_is_GNU( $Config{cc} ) ) { $config{CC} = 'g++' }
  else { warn 'unknown compiler: set EXTRA_CFLAGS to force C++ mode'
           unless length( $wxConfig::extra_cflags ) > 1 }

  if( $wxConfig::debug_mode ) {
    $config{CCFLAGS} .= ' -g ';
    $config{OPTIMIZE} = ' ';
  }

  if( ld_is_GNU( $Config{ld} ) ) { $config{LD} = 'g++ -shared' }

  $cccflags = wx_config( 'cflags' );
  $libs = wx_config( 'libs' );

  foreach ( split ' ', $cccflags ) {
    m(^[-/]I) && do { $config{INC} .= $_ . ' '; next; };
    m(^[-/]D) && do { $config{DEFINE} .= $_ . ' '; next; };
    $config{CCFLAGS} .= $_ . ' ';
  }

  $config{LIBS} .= ' ' . $libs;

  \%config;
}

sub wx_lib {
  my( $this, $lib ) = @_;
  $lib =~ s/^\s*(.*?)\s*/$1/;

  return " -l$lib ";
}

1;

# Local variables: #
# mode: cperl #
# End: #
