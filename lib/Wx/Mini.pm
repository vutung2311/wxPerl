package Wx::Mini; # for RPM

package Wx;

use strict;

our( $VERSION, $XS_VERSION );
our $alien_key = 'XXXALIENXXX';

{
    my $VAR1;
    $Wx::dlls = XXXDLLSXXX;
}

$VERSION = '0.94'; # bootstrap will catch wrong versions
$XS_VERSION = $VERSION;
$VERSION = eval $VERSION;

#
# XSLoader/DynaLoader wrapper
#
our( $wx_path );

sub wxPL_STATIC();
sub wx_boot($$) {
  local $ENV{PATH} = $wx_path . ';' . $ENV{PATH} if $wx_path;
  if( $_[0] eq 'Wx' || !wxPL_STATIC ) {
    if( $] < 5.006 ) {
      require DynaLoader;
      no strict 'refs';
      push @{"$_[0]::ISA"}, 'DynaLoader';
      $_[0]->bootstrap( $_[1] );
    } else {
      require XSLoader;
      XSLoader::load( $_[0], $_[1] );
    }
  } else {
    no strict 'refs';
    my $t = $_[0]; $t =~ tr/:/_/;
    &{"_boot_$t"}( $_[0], $_[1] );
  }
}

sub _alien_path {
  return if defined $wx_path;
  return unless length 'XXXALIENDXXX';
  foreach ( @INC ) {
    if( -d "$_/Alien/wxWidgets/XXXALIENDXXX" ) {
      $wx_path = "$_/Alien/wxWidgets/XXXALIENDXXX/lib";
      last;
    }
  }
}

_alien_path();

sub _start {
    wx_boot( 'Wx', $XS_VERSION );

    _boot_Constant( 'Wx', $XS_VERSION );
    _boot_GDI( 'Wx', $XS_VERSION );

    Load();
}

1;
