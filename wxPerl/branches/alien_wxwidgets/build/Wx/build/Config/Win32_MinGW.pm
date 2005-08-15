package Wx::build::Config::Win32_MinGW;

use strict;
use base 'Wx::build::Config::Any_OS';
use File::Spec::Functions qw(catfile catdir rel2abs canonpath);
use File::Basename 'dirname';
use Cwd ();
use Config;

my $makefile = "waggawagga";

sub wx_config_24 {
  my $this = shift;

  if( $_[0] eq 'dlls' ) {
    my $implib = $this->wx_config( 'implib' );
    $implib = $this->_replace_implib_24( $implib )
      unless Wx::build::Config::is_wxPerl_tree();
    my $dll = $implib;
    $dll =~ s/\.a$/.dll/; $dll =~ s/lib(wx[\w\.]+)$/$1/;
    return { core => { dll => $dll, lib => $implib } };
  }

  my $final = $this->_debug ? 'FINAL=0' : 'FINAL=1';
  my $unicode = $this->_unicode ? 'UNICODE=1' : 'UNICODE=0';
  $unicode .= ' EXTRALIBS=-lunicows' if $this->_mslu;
  my $t = qx(make -s -f $makefile @_ $final $unicode CXXFLAGS=-Os);
  chomp $t;
  if( $_[0] eq 'libs' && !Wx::build::Config::is_wxPerl_tree() ) {
    return $this->_replace_implib_24( $t );
  }
  return $t;
}

sub get_core_lib {
  my( $this, @libs ) = @_;

  return join ' ', Alien::wxWidgets->libraries( @libs );
}

sub get_core_lib_25 {
  my( $this, @libs ) = @_;
  my $dlls = $this->wx_config( 'dlls' );

  return join ' ',
    map { exists( $dlls->{$_} ) ? $dlls->{$_}{lib} :
                                  die "No such lib '$_'" }
    @libs;
}

sub get_core_lib_24 {
  my( $this, @libs ) = @_;
  my $dlls = $this->wx_config( 'dlls' );

  return ' ' . join ' ',
    map {
        return () if m/^gl$/ && $^O eq 'MSWin32';

        m/^(?:xrc|stc)$/     ? $this->get_contrib_lib( $_ ) :
        exists($dlls->{$_} ) ? $dlls->{$_}{lib}           :
                               die "No such lib: '$_'";
    }
#   FXME: core
    grep { !m/^(?:adv|base|html|net|xml|core)$/ } @libs;
}

sub get_contrib_lib_24 {
  my( $this, $lib ) = @_;

  $lib = 'wxxrc' if $lib eq 'xrc';
  $lib =~ s/^\s*(.*?)\s*/$1/;

  return ' ' . catfile( $this->wx_config( 'wxdir' ),
                        'lib',
                        "lib${lib}$Config{lib_ext}" ) . ' ';
}

sub get_flags {
  my $this = shift;
  my %config = $this->SUPER::get_flags;

  $config{CC} = Alien::wxWidgets->compiler;
  $config{LD} = Alien::wxWidgets->linker;
  $config{CCFLAGS} .= Alien::wxWidgets->c_flags . ' ';
  $config{dynamic_lib}{OTHERLDFLAGS} .= Alien::wxWidgets->link_flags . ' ';
  $config{clean}{FILES} .= 'dll.base dll.exp ';
  $config{DEFINE} .= Alien::wxWidgets->defines . ' ';
  $config{INC} .= Alien::wxWidgets->include_path;

  if( $this->_debug ) {
    $config{OPTIMIZE} = ' ';
  }

  # add $MINGWDIR/lib to lib search path, to stop perl from complaining...
  my $path = Wx::build::Utils::path_search( 'gcc.exe' )
    or warn "Unable to find gcc";
  $path =~ s{bin[\\/]gcc\.exe$}{}i;
  $config{LIBS} = "-L${path}lib " . ( $config{LIBS} || '' );

  return %config;
}

1;

# local variables:
# mode: cperl
# end:
