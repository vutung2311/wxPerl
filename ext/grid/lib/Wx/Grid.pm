#############################################################################
## Name:        Grid.pm
## Purpose:     Wx::Grid ( pulls in all Wx::Grid* stuff )
## Author:      Mattia Barbon
## Modified by:
## Created:      4/12/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Grid;

use Wx;
use strict;

require DynaLoader;

use vars qw(@ISA $VERSION);

$VERSION = '0.01';
@ISA = qw(DynaLoader);

bootstrap Wx::Grid;

#
# properly setup inheritance tree
#

no strict;

package Wx::Grid; @ISA = qw(Wx::ScrolledWindow);

package Wx::Grid;

use strict;
use Carp;

# this is for make_ovl_list to find constants
sub CellToRect {
  my $this = shift;

  Wx::_match( @_, $Wx::_wgco, 1 ) && return $this->CellToRectCo( @_ );
  Wx::_match( @_, $Wx::_n_n, 2 )  && return $this->CellToRectXY( @_ );
  croak Wx::_ovl_error;
}

sub _create_ovls {
  my $name = shift;

  no strict;
  die $name unless defined &{$name . 'XY'} && defined &{$name . 'Co'};
  use strict;

  eval <<EOT;
sub ${name} {
  my \$this = shift;

  Wx::_match( \@_, \$Wx::_wgco, 1 ) && return \$this->${name}Co( @_ );
  Wx::_match( \@_, \$Wx::_n_n, 2 )  && return \$this->${name}XY( @_ );
  croak Wx::_ovl_error;
}
EOT

  die $@ if $@;
}

foreach my $i ( qw(GetCellValue IsInSelection IsVisible MakeCellVisible
                   ) ) { _create_ovls( $i ); }

sub SelectBlock {
  my $this = shift;

  Wx::_match( @_, $Wx::_wgco_wgco_b, 3 ) && return $this->SelectBlockPP( @_ );
  Wx::_match( @_, $Wx::_n_n_n_n_b, 5 )  && return $this->SelectBlockXYWH( @_ );
  croak Wx::_ovl_error;
}

sub SetCellValue {
  my $this = shift;

  Wx::_match( @_, $Wx::_wgco_s, 2 ) && return $this->SetCellValueXY( @_ );
  Wx::_match( @_, $Wx::_n_n_s, 3 )  && return $this->SetCellValueCo( @_ );
  croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
