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

package Wx::Region;

use strict;
use Carp;

*Wx::Size::y = \&Wx::Size::height;
*Wx::Size::x = \&Wx::Size::width;

sub new {
  shift;

  Wx::_match( @_, $Wx::_n_n_n_n, 4 )   && return Wx::Region::newXYWH( @_ );
  Wx::_match( @_, $Wx::_wpoi_wpoi, 2 ) && return Wx::Region::newPP( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 )      && return Wx::Region::newRect( @_ );
  croak Wx::_ovl_error 'Wx::Region::new';
}

sub Contains {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n_n_n, 4 ) && return $this->ContainsXYWH( @_ );
  Wx::_match( @_, $Wx::_n_n, 2 )     && return $this->ContainsXY( @_ );
  Wx::_match( @_, $Wx::_wpoi, 1 )    && return $this->ContainsPoint( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 )    && return $this->ContainsRect( @_ );
  croak Wx::_ovl_error 'Wx::Region::Contains';
}

sub Intersect {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n_n_n, 4 ) && return $this->IntersectXYWH( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 )    && return $this->IntersectRect( @_ );
  Wx::_match( @_, $Wx::_wreg, 1 )    && return $this->IntersectRegion( @_ );
  croak Wx::_ovl_error 'Wx::Region::Intersect';
}

sub Subtract {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wreg, 1 ) && return $this->SubtractRegion( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 ) && return $this->SubtractRect( @_ );
  croak Wx::_ovl_error 'Wx::Region::Subtract';
}

sub Union {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n_n_n, 4 ) && return $this->UnionXYWH( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 )    && return $this->UnionRect( @_ );
  Wx::_match( @_, $Wx::_wreg, 1 )    && return $this->UnionRegion( @_ );
  croak Wx::_ovl_error 'Wx::Region::Union';
}

sub Xor {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n_n_n, 4 ) && return $this->XorXYWH( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 )    && return $this->XorRect( @_ );
  Wx::_match( @_, $Wx::_wreg, 1 )    && return $this->XorRegion( @_ );
  croak Wx::_ovl_error 'Wx::Region::Xor';
}

1;

# Local variables: #
# mode: cperl #
# End: #
