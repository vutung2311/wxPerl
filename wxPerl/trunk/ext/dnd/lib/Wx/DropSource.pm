#############################################################################
## Name:        DropSource.pm
## Purpose:     Wx::DropSource
## Author:      Mattia Barbon
## Modified by:
## Created:     17/ 8/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::DropSource;

sub new {
  my $this = shift;

  if( $Wx::_platform != $Wx::_msw ) {
    Wx::_match( @_, $Wx::_wwin_wico_wico_wico, 0, 1 ) && return $this->newIconEmpty( @_ );
    Wx::_match( @_, $Wx::_wdat_wwin_wico_wico_wico, 1, 1 ) && return $this->newIconData( @_ );
  } else {
    Wx::_match( @_, $Wx::_wwin_wcur_wcur_wcur, 0, 1 ) && return $this->newCursorEmpty( @_ );
    Wx::_match( @_, $Wx::_wdat_wwin_wcur_wcur_wcur, 1, 1 ) && return $this->newCursorData( @_ );
  }

  Wx::_croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
