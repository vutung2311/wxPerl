#############################################################################
## Name:        Validator.xs
## Purpose:     XS for Wx::Validator
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Validator

Wx_Validator*
Wx_Validator::new()

Wx_Window*
Wx_Validator::GetWindow()

void
Wx_Validator::SetBellOnError( doit = TRUE )
    bool doit

void
Wx_Validator::SetWindow( window )
    Wx_Window* window

bool
Wx_Validator::TransferFromWindow()

bool
Wx_Validator::TransferToWindow()

bool
Wx_Validator::Validate( parent )
    Wx_Window* parent

MODULE=Wx PACKAGE=Wx::PlValidator

Wx_PlValidator*
Wx_PlValidator::new()
  CODE:
    RETVAL = new _wxPlValidator( CLASS );
  OUTPUT:
    RETVAL


