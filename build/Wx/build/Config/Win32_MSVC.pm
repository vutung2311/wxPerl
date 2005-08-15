package Wx::build::Config::Win32_MSVC;

use strict;
use base 'Wx::build::Config::Any_OS';
use File::Spec::Functions qw(catfile catdir rel2abs canonpath);
use File::Basename 'dirname';
use Cwd ();
use Config;

sub get_core_lib {
  my( $this, @libs ) = @_;

  return join ' ', Alien::wxWidgets->libraries( @libs );
}

sub get_core_lib_24 {
  my( $this, @libs ) = @_;
  my $dlls = $this->wx_config( 'dlls' );

  return ' ' . join ' ',
    map {
        m/^(?:xrc|stc)$/     ? $this->get_contrib_lib_24( $_ ) :
        exists($dlls->{$_} ) ? $dlls->{$_}{lib}           :
                               die "No such lib: '$_'";
    }
    grep { !m/^(?:adv|base|html|net|xml)$/ } @libs;
}

sub get_contrib_lib_24 {
  my( $this, $lib ) = @_;
  my $suff = $this->_debug ? 'h' : '';

  $lib = 'wxxrc' if $lib eq 'xrc';
  $lib =~ s/^\s*(.*?)\s*/$1/;

  return ' ' . catfile( $this->wx_config( 'wxdir' ),
                        'lib',
                        "${lib}${suff}$Config{lib_ext}" ) . ' ';
}

sub get_flags {
  my $this = shift;
  my %config = $this->SUPER::get_flags;

  $config{CC} = Alien::wxWidgets->compiler;
  $config{LD} = Alien::wxWidgets->linker;
  $config{CCFLAGS} .= Alien::wxWidgets->c_flags . ' ';
  $config{dynamic_lib}{OTHERLDFLAGS} .= Alien::wxWidgets->link_flags . ' ';
  $config{clean}{FILES} .= ' *.pdb *.pdb *_def.old ';
  $config{DEFINE} .= Alien::wxWidgets->defines . ' ';
  $config{INC} .= Alien::wxWidgets->include_path;

  if( $this->_debug ) {
    $config{OPTIMIZE} = ' ';
  }

  return %config;
}

1;

# local variables:
# mode: cperl
# end:
