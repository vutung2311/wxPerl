#############################################################################
## Name:        App.pm
## Purpose:     Wx::App class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::App;

use strict;
use vars qw(@ISA $theapp);

use Carp;

@ISA = qw(Wx::_App);

sub new {
  croak "Only one 'Wx::App' instance allowed" if $theapp;

  my($this)=$_[0]->SUPER::new();

  $theapp = $this;

  Wx::_App::Start($this,$this->can('OnInit'));

  $this;
}

# sub DESTROY {
# }

sub OnInit {
  0;
}

1;

# Local variables: #
# mode: cperl #
# End: #
