#############################################################################
## Name:        Region.pm
## Purpose:     Wx::Region class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Size;

no strict;

*y = \&Wx::Size::height;
*x = \&Wx::Size::width;

package Wx::Region;

use strict;

sub new {
  shift;

  Wx::_match( @_, $Wx::_n_n_n_n, 4 )   && return Wx::Region::newXYWH( @_ );
  Wx::_match( @_, $Wx::_wpoi_wpoi, 2 ) && return Wx::Region::newPP( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 )      && return Wx::Region::newRect( @_ );
  Wx::_match( @_, $Wx::_arr, 1, 1 )    && return Wx::Region::newPolygon( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub Contains {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n_n_n, 4 ) && return $this->ContainsXYWH( @_ );
  Wx::_match( @_, $Wx::_n_n, 2 )     && return $this->ContainsXY( @_ );
  Wx::_match( @_, $Wx::_wpoi, 1 )    && return $this->ContainsPoint( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 )    && return $this->ContainsRect( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub Intersect {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n_n_n, 4 ) && return $this->IntersectXYWH( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 )    && return $this->IntersectRect( @_ );
  Wx::_match( @_, $Wx::_wreg, 1 )    && return $this->IntersectRegion( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub Subtract {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wreg, 1 ) && return $this->SubtractRegion( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 ) && return $this->SubtractRect( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub Union {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n_n_n, 4 ) && return $this->UnionXYWH( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 )    && return $this->UnionRect( @_ );
  Wx::_match( @_, $Wx::_wreg, 1 )    && return $this->UnionRegion( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub Xor {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n_n_n, 4 ) && return $this->XorXYWH( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 )    && return $this->XorRect( @_ );
  Wx::_match( @_, $Wx::_wreg, 1 )    && return $this->XorRegion( @_ );
  Wx::_croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
