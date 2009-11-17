#############################################################################
## Name:        XS/ImageHandler.xs
## Purpose:     XS for Wx::ImageHandler
## Author:      Mattia Barbon
## Modified by:
## Created:     02/12/2000
## RCS-ID:      $Id: Image.xs 2626 2009-10-18 22:48:17Z mbarbon $
## Copyright:   (c) 2000-2003, 2005-2009 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/image.h>
#include "cpp/streams.h"

MODULE=Wx PACKAGE=Wx::ImageHandler

void
wxImageHandler::Destroy()
  CODE:
    delete THIS;

int
wxImageHandler::GetImageCount( stream )
    wxPliInputStream stream

wxString
wxImageHandler::GetName()

wxString
wxImageHandler::GetExtension()

#if WXPERL_W_VERSION_GE( 2, 9, 0 )

wxBitmapType
wxImageHandler::GetType()

#else

long
wxImageHandler::GetType()

#endif

wxString
wxImageHandler::GetMimeType()

bool
wxImageHandler::LoadFile( image, stream, verbose = true, index = 0 )
    wxImage* image
    wxPliInputStream stream
    bool verbose
    int index

bool
wxImageHandler::SaveFile( image, stream )
    wxImage* image
    wxPliOutputStream stream

void
wxImageHandler::SetName( name )
    wxString name

void
wxImageHandler::SetExtension( ext )
    wxString ext

void
wxImageHandler::SetMimeType( type )
    wxString type

void
wxImageHandler::SetType( type )
    wxBitmapType type

MODULE=Wx PACKAGE=Wx::GIFHandler

wxGIFHandler*
wxGIFHandler::new()

MODULE=Wx PACKAGE=Wx::BMPHandler

wxBMPHandler*
wxBMPHandler::new()

MODULE=Wx PACKAGE=Wx::PNMHandler

wxPNMHandler*
wxPNMHandler::new()

MODULE=Wx PACKAGE=Wx::PCXHandler

wxPCXHandler*
wxPCXHandler::new()

MODULE=Wx PACKAGE=Wx::PNGHandler

wxPNGHandler*
wxPNGHandler::new()

MODULE=Wx PACKAGE=Wx::JPEGHandler

wxJPEGHandler*
wxJPEGHandler::new()

#if wxPERL_USE_LIBTIFF && !defined( __WXWINCE__ )

MODULE=Wx PACKAGE=Wx::TIFFHandler

wxTIFFHandler*
wxTIFFHandler::new()

#endif

MODULE=Wx PACKAGE=Wx::XPMHandler

wxXPMHandler*
wxXPMHandler::new()

MODULE=Wx PACKAGE=Wx::IFFHandler

#if wxPERL_USE_IFF

wxIFFHandler*
wxIFFHandler::new()

#endif

#if wxPERL_USE_ICO_CUR

MODULE=Wx PACKAGE=Wx::ICOHandler

wxICOHandler*
wxICOHandler::new()

MODULE=Wx PACKAGE=Wx::CURHandler

wxCURHandler*
wxCURHandler::new()

MODULE=Wx PACKAGE=Wx::ANIHandler

wxANIHandler*
wxANIHandler::new()

#endif

#if wxUSE_TGA

MODULE=Wx PACKAGE=Wx::TGAHandler

wxTGAHandler*
wxTGAHandler::new()

#endif

MODULE=Wx PACKAGE=Wx PREFIX=wx

void
wxInitAllImageHandlers()
