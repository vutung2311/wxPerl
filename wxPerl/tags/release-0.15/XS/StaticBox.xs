#############################################################################
## Name:        StaticBox.xs
## Purpose:     XS for Wx::StaticBox
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000-2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/statbox.h>

MODULE=Wx PACKAGE=Wx::StaticBox

Wx_StaticBox*
Wx_StaticBox::new( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxStaticBoxNameStr )
    Wx_Window* parent
    wxWindowID id
    wxString label
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliStaticBox( CLASS, parent, id, label, pos, 
        size, style, name );
  OUTPUT:
    RETVAL
