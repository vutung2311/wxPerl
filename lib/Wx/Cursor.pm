#############################################################################
## Name:        Cursor.pm
## Purpose:     Wx::Cursor class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Cursor;

use strict;
use Carp;

sub new {
  shift;

  Wx::_match( @_, $Wx::_n, 1 )          && return Wx::Cursor::newId( @_ );
  Wx::_match( @_, $Wx::_s_n_n_n, 2, 1 ) && return Wx::Cursor::newFile( @_ );
  croak Wx::_ovl_error 'Wx::Cursor::new';
}

1;

# Local variables: #
# mode: cperl #
# End: #
