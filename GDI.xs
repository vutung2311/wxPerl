/////////////////////////////////////////////////////////////////////////////
// Name:        GDI.xs
// Purpose:     XS for various GDI objects
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool
#define PERL_NO_GET_CONTEXT

#include <wx/defs.h>
#include <stdarg.h>

#include "cpp/compat.h"
#include "cpp/chkconfig.h"

WXPL_EXTERN_C_START
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
WXPL_EXTERN_C_END

#undef bool
#undef Move
#undef Copy
#undef New
#undef Pause
#if defined( __WXMSW__ )
#undef read
#undef write
#undef eof
#undef form
#undef vform
#endif

#if __VISUALC__
#pragma warning (disable: 4800 )
#endif

#ifdef __WXMSW__
#include <wx/msw/winundef.h>
#endif // __WXMSW__

// some helper functions/classes/macros
#include "cpp/typedef.h"
#include "cpp/helpers.h"

#undef THIS
WXPLI_BOOT_ONCE(Wx_GDI);
#define boot_Wx_GDI wxPli_boot_Wx_GDI

MODULE=Wx_GDI

INCLUDE: XS/Colour.xs
INCLUDE: XS/Font.xs
INCLUDE: XS/ImageList.xs
INCLUDE: XS/Bitmap.xs
INCLUDE: XS/Icon.xs
INCLUDE: XS/Cursor.xs
INCLUDE: XS/DC.xs
INCLUDE: XS/Pen.xs
INCLUDE: XS/Brush.xs
INCLUDE: XS/Image.xs
INCLUDE: XS/Palette.xs

MODULE=Wx PACKAGE=Wx

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

Wx_Rect*
GetClientDisplayRect()
  CODE:
    RETVAL = new wxRect( wxGetClientDisplayRect() );
  OUTPUT:
    RETVAL

#endif

MODULE=Wx_GDI
