#############################################################################
## Name:        Image.xs
## Purpose:     XS for Wx::Image
## Author:      Mattia Barbon
## Modified by:
## Created:      2/12/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Image

#FIXME// unimplemented
# some constructors
# some loadfile
# methods returning ImageHandlers
# SetData
# GetData
# overloaded operators

Wx_Image*
newNull()
  CODE:
    RETVAL = new wxImage();
  OUTPUT:
    RETVAL

Wx_Image*
newBitmap( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    RETVAL = new wxImage( *bitmap );
  OUTPUT:
    RETVAL

Wx_Image*
newWH( width, height )
    int width
    int height
  CODE:
    RETVAL = new wxImage( width, height );
  OUTPUT:
    RETVAL

Wx_Image*
newNameType( name, type )
    wxString name
    long type
  CODE:
    RETVAL = new wxImage( name, type );
  OUTPUT:
    RETVAL

Wx_Image*
newNameMIME( name, mimetype )
    wxString name
    wxString mimetype
  CODE:
    RETVAL = new wxImage( name, mimetype );
  OUTPUT:
    RETVAL

void
Wx_Image::DESTROY()

void
AddHandler( handler )
    Wx_ImageHandler* handler
  CODE:
    wxImage::AddHandler( handler );

Wx_Bitmap*
Wx_Image::ConvertToBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->ConvertToBitmap() );
  OUTPUT:
    RETVAL

Wx_Image*
Wx_Image::Copy()
  CODE:
    RETVAL = new wxImage( THIS->Copy() );
  OUTPUT:
    RETVAL

void
Wx_Image::Create( width, height )
    int width
    int height

void
Wx_Image::Destroy()

Wx_ImageHandler*
FindHandlerName( name )
    wxString name
  CODE:
    RETVAL = wxImage::FindHandler( name );
  OUTPUT:
    RETVAL

Wx_ImageHandler*
FindHandlerExtType( extension, type )
    wxString extension
    long type
  CODE:
    RETVAL = wxImage::FindHandler( extension, type );
  OUTPUT:
    RETVAL

Wx_ImageHandler*
FindHandlerType( type )
    long type
  CODE:
    RETVAL = wxImage::FindHandler( type );
  OUTPUT:
    RETVAL

Wx_ImageHandler*
FindHandlerMime( mime )
   wxString mime
  CODE:
    RETVAL = wxImage::FindHandlerMime( mime );
  OUTPUT:
    RETVAL

unsigned char
Wx_Image::GetBlue( x, y )
    int x
    int y

unsigned char
Wx_Image::GetGreen( x, y )
    int x
    int y

unsigned char
Wx_Image::GetRed( x, y )
    int x
    int y

int
Wx_Image::GetHeight()

unsigned char
Wx_Image::GetMaskBlue()

unsigned char
Wx_Image::GetMaskGreen()

unsigned char
Wx_Image::GetMaskRed()

# Wx_Palette*
# Wx_Image::GetPalette()
#   CODE:
#     RETVAL = new wxPalette( THIS->GetPalette() );
#   OUTPUT:
#     RETVAL

Wx_Image*
Wx_Image::GetSubImage( rect )
    Wx_Rect* rect
  CODE:
    RETVAL = new wxImage( THIS->GetSubImage( *rect ) );
  OUTPUT:
    RETVAL

int
Wx_Image::GetWidth()

bool
Wx_Image::HasMask()

void
InsertHandler( handler )
    Wx_ImageHandler* handler
  CODE:
    wxImage::InsertHandler( handler );

bool
Wx_Image::LoadFileType( name, type )
    wxString name
    long type
  CODE:
    RETVAL = THIS->LoadFile( name, type );
  OUTPUT:
    RETVAL

bool
Wx_Image::LoadFileMIME( name, type )
    wxString name
    wxString type
  CODE:
    RETVAL = THIS->LoadFile( name, type );
  OUTPUT:
    RETVAL

bool
Wx_Image::Ok()

bool
Wx_Image::SaveFileType( name, type )
    wxString name
    long type
  CODE:
    RETVAL = THIS->SaveFile( name, type );
  OUTPUT:
    RETVAL

bool
Wx_Image::SaveFileMIME( name, type )
    wxString name
    wxString type
  CODE:
    RETVAL = THIS->SaveFile( name, type );
  OUTPUT:
    RETVAL

void
Wx_Image::Mirror( horizontally = TRUE )
    bool horizontally

void
Wx_Image::Replace( r1, g1, b1, r2, g2, b2 )
    unsigned char r1
    unsigned char g1
    unsigned char b1
    unsigned char r2
    unsigned char g2
    unsigned char b2

Wx_Image*
Wx_Image::Rescale( width, height )
    int width
    int height
  CODE:
    RETVAL = new wxImage( THIS->Rescale( width, height ) );
  OUTPUT:
    RETVAL

void
Wx_Image::Rotate( angle, centre, interpolating = TRUE )
    double angle
    Wx_Point centre
    bool interpolating
  PREINIT:
    wxPoint after;
    wxImage* result;
  PPCODE:
    result = new wxImage( THIS->Rotate( angle, centre, interpolating, &after ) );
    XPUSHs( _object_2_sv( sv_newmortal(), result ) );
    if( GIMME_V == G_ARRAY ) {
      PUSHs( _non_object_2_sv( sv_newmortal(), 
             new wxPoint( after ), wxPlPointName ) );
    }

Wx_Image*
Wx_Image::Rotate90( clockwise = TRUE )
    bool clockwise
  CODE:
    RETVAL = new wxImage( THIS->Rotate90( clockwise ) );
  OUTPUT:
    RETVAL

Wx_Image*
Wx_Image::Scale( width, height )
    int width
    int height
  CODE:
    RETVAL = new wxImage( THIS->Scale( width, height ) );
  OUTPUT:
    RETVAL

void
Wx_Image::SetMask( hasMask = TRUE )
    bool hasMask

void
Wx_Image::SetMaskColour( red, green, blue )
    unsigned char red
    unsigned char green
    unsigned char blue

# void
# Wx_Image::SetPalette( palette )
#     Wx_Palette* palette
#   CODE:
#     THIS->SetPalette( *palette );

void
Wx_Image::SetRGB( x, y, red, green, blue )
    int x
    int y
    unsigned char red
    unsigned char green
    unsigned char blue

MODULE=Wx PACKAGE=Wx::ImageHandler

#FIXME// unimplemented
# GetImageCount
# LoadFile
# SaveFile

void
Wx_ImageHandler::Destroy()
  CODE:
    delete THIS;

wxString
Wx_ImageHandler::GetName()

wxString
Wx_ImageHandler::GetExtension()

long
Wx_ImageHandler::GetType()

wxString
Wx_ImageHandler::GetMimeType()

void
Wx_ImageHandler::SetName( name )
    wxString name

void
Wx_ImageHandler::SetExtension( ext )
    wxString ext

void
Wx_ImageHandler::SetMimeType( type )
    wxString type

void
Wx_ImageHandler::SetType( type )
    long type

MODULE=Wx PACKAGE=Wx::GIFHandler

Wx_GIFHandler*
Wx_GIFHandler::new()

MODULE=Wx PACKAGE=Wx::BMPHandler

Wx_BMPHandler*
Wx_BMPHandler::new()

MODULE=Wx PACKAGE=Wx::PNMHandler

Wx_PNMHandler*
Wx_PNMHandler::new()

MODULE=Wx PACKAGE=Wx::PCXHandler

Wx_PCXHandler*
Wx_PCXHandler::new()

MODULE=Wx PACKAGE=Wx::PNGHandler

Wx_PNGHandler*
Wx_PNGHandler::new()

MODULE=Wx PACKAGE=Wx::JPEGHandler

Wx_JPEGHandler*
Wx_JPEGHandler::new()

MODULE=Wx PACKAGE=Wx::TIFFHandler

Wx_TIFFHandler*
Wx_TIFFHandler::new()
