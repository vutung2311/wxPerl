#############################################################################
## Name:        CheckBox.xs
## Purpose:     XS for Wx::CheckBox
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::CheckBox

Wx_CheckBox*
Wx_CheckBox::new( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxCheckBoxNameStr )
    Wx_Window* parent
    wxWindowID id
    wxString label
    Wx_Point pos
    Wx_Size size
    long style
    Wx_Validator* validator
    wxString name
  CODE:
    RETVAL = new wxPliCheckBox( CLASS, parent, id, label, pos, size, 
        style, *validator, name );
  OUTPUT:
    RETVAL

bool
Wx_CheckBox::GetValue()

void
Wx_CheckBox::SetValue( state )
    bool state

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

bool
Wx_CheckBox::IsChecked()

#endif
