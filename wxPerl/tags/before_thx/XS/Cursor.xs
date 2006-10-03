#############################################################################
## Name:        Cursor.xs
## Purpose:     XS for Wx::Cursor
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/cursor.h>

MODULE=Wx PACKAGE=Wx::Cursor

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

Wx_Cursor*
newFile( name, type, hsx = -1, hsy = -1 )
    wxString name
    long type
    int hsx
    int hsy
  CODE:
    RETVAL = new wxCursor( name, type, hsx, hsy );
  OUTPUT:
    RETVAL

#endif

Wx_Cursor*
newId( id )
    wxStockCursor id
  CODE:
    RETVAL = new wxCursor( id );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

Wx_Cursor*
newImage( img )
    Wx_Image* img
  CODE:
    RETVAL = new wxCursor( *img );
  OUTPUT:
    RETVAL

#endif

#if !defined( __WXGTK__ )

Wx_Cursor*
newData( bits, width, height, hotSpotX = -1, hotSpotY = -1, maskBits = 0 )
    SV* bits
    int width
    int height
    int hotSpotX
    int hotSpotY
    SV* maskBits
  PREINIT:
    char* data = SvPV_nolen( bits );
    char* mask = maskBits ? SvPV_nolen( maskBits ) : 0;
  CODE:
    RETVAL = new wxCursor( data, width, height, hotSpotX, hotSpotY, mask );
  OUTPUT:
    RETVAL

#endif

void
Wx_Cursor::DESTROY()

bool
Wx_Cursor::Ok()