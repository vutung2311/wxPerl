/////////////////////////////////////////////////////////////////////////////
// Name:        GDI.xs
// Purpose:     XS for various GDI objects
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: GDI.xs,v 1.19 2005/04/03 09:14:29 mbarbon Exp $
// Copyright:   (c) 2000-2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool
#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/typedef.h"

#undef THIS

WXPLI_BOOT_ONCE(Wx_GDI);
#define boot_Wx_GDI wxPli_boot_Wx_GDI

MODULE=Wx_GDI

INCLUDE: XS/Colour.xs
INCLUDE: XS/Font.xs
INCLUDE: perl script/xsubppp.pl --typemap typemap.xsp XS/ImageList.xs |
INCLUDE: XS/Bitmap.xs
INCLUDE: XS/Icon.xs
INCLUDE: XS/Cursor.xs
INCLUDE: XS/DC.xs
INCLUDE: XS/Pen.xs
INCLUDE: XS/Brush.xs
INCLUDE: XS/Image.xs
INCLUDE: XS/Palette.xs

MODULE=Wx PACKAGE=Wx PREFIX=wx

wxRect*
wxGetClientDisplayRect()
  CODE:
    RETVAL = new wxRect( wxGetClientDisplayRect() );
  OUTPUT:
    RETVAL

bool
wxColourDisplay()
  CODE:
    RETVAL = wxColourDisplay();
  OUTPUT:
    RETVAL

int
wxDisplayDepth()
  CODE:
    RETVAL = wxDisplayDepth();
  OUTPUT:
    RETVAL

wxSize*
wxGetDisplaySizeMM()
  CODE:
    RETVAL = new wxSize( wxGetDisplaySizeMM() );
  OUTPUT:
    RETVAL

wxSize*
wxGetDisplaySize()
  CODE:
    RETVAL = new wxSize( wxGetDisplaySize() );
  OUTPUT:
    RETVAL

MODULE=Wx_GDI