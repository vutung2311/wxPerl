#############################################################################
## Name:        Locale.pm
## Purpose:     Wx::Locale
## Author:      Mattia Barbon
## Modified by:
## Created:      2/ 2/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Locale;

use strict;
use Carp;

push @Wx::EXPORT_OK, qw(_ _noop gettext_noop gettext);

*Wx::_ = \&Wx::GetTranslation;
*Wx::gettext = \&Wx::GetTranslation;
*Wx::_noop = sub { $_[0] };
*Wx::gettext_noop = \&Wx::_noop;

sub new {
  shift;

  # this should be conditionally defined, but it does no harm to leave
  # like it is
  Wx::_match( @_, $Wx::_n_n, 2 )          && return Wx::Locale::newShort( @_ );
  Wx::_match( @_, $Wx::_s_s_s_b_b, 1, 1 ) && return Wx::Locale::newLong( @_ );
  croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
