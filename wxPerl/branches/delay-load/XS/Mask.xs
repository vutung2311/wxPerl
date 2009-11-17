/////////////////////////////////////////////////////////////////////////////
// Name:        XS/Mask.xs
// Purpose:     XS for Wx::Mask
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: Bitmap.xs 2069 2007-07-08 15:33:40Z mbarbon $
// Copyright:   (c) 2000-2002, 2005-2007, 2009 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT
#include "cpp/wxapi.h"
#include "cpp/overload.h"
#include <wx/bitmap.h>

MODULE=Wx_Mask PACKAGE=Wx::Mask

void
wxMask::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wbmp_wcol, newBitmapColour )
        MATCH_REDISP( wxPliOvl_wbmp_n, newBitmapIndex )
        MATCH_REDISP( wxPliOvl_wbmp, newBitmap )
    END_OVERLOAD( Wx::Mask::new )

wxMask*
newBitmap( CLASS, bitmap )
    SV* CLASS
    wxBitmap* bitmap
  CODE:
    RETVAL = new wxMask( *bitmap );
  OUTPUT:
    RETVAL

wxMask*
newBitmapColour( CLASS, bitmap, colour )
    SV* CLASS
    wxBitmap* bitmap
    wxColour* colour
  CODE:
    RETVAL = new wxMask( *bitmap, *colour );
  OUTPUT:
    RETVAL

wxMask*
newBitmapIndex( CLASS, bitmap, index )
    SV* CLASS
    wxBitmap* bitmap
    int index
  CODE:
    RETVAL = new wxMask( *bitmap, index );
  OUTPUT:
    RETVAL

void
wxMask::Destroy()
  CODE:
    delete THIS;
