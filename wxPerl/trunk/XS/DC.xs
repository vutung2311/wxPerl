#############################################################################
## Name:        DC.xs
## Purpose:     XS for Wx::DC and derived classes
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::DC

void
Wx_DC::DESTROY()

void
Wx_DC::BeginDrawing()

bool
Wx_DC::Blit( xdest, ydest, width, height, source, xsrc, ysrc, logicalFunc = wxCOPY, useMask = FALSE )
    wxCoord xdest
    wxCoord ydest
    wxCoord width
    wxCoord height
    Wx_DC* source
    wxCoord xsrc
    wxCoord ysrc
    int logicalFunc
    bool useMask

void
Wx_DC::CalcBoundingBox( x, y )
    wxCoord x
    wxCoord y

void
Wx_DC::Clear()

void
Wx_DC::CrossHair( x, y )
    wxCoord x
    wxCoord y

void
Wx_DC::DestroyClippingRegion()

wxCoord
Wx_DC::DeviceToLogicalX( x )
    wxCoord x

wxCoord
Wx_DC::DeviceToLogicalXRel( x )
    wxCoord x

wxCoord
Wx_DC::DeviceToLogicalY( y )
    wxCoord y

wxCoord
Wx_DC::DeviceToLogicalYRel( y )
    wxCoord y

void
Wx_DC::DrawArc( x1, y1, x2, y2, xc, yc )
    wxCoord x1
    wxCoord y1
    wxCoord x2
    wxCoord y2
    wxCoord xc
    wxCoord yc

void
Wx_DC::DrawBitmap( bitmap, x, y, transparent )
    Wx_Bitmap* bitmap
    wxCoord x
    wxCoord y
    bool transparent
  CODE:
    THIS->DrawBitmap( *bitmap, x, y, transparent );

void
Wx_DC::DrawCheckMarkXYWH( x, y, width, height )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height
  CODE:
    THIS->DrawCheckMark( x, y, width, height );

void
Wx_DC::DrawCheckMarkRect( rect )
    Wx_Rect* rect
  CODE:
    THIS->DrawCheckMark( *rect );

void
Wx_DC::DrawEllipse( x, y, width, height )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height

void
Wx_DC::DrawEllipticArc( x, y, width, height, start, end )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height
    double start
    double end

void
Wx_DC::DrawIcon( icon, x, y )
    Wx_Icon* icon
    wxCoord x
    wxCoord y
  CODE:
    THIS->DrawIcon( *icon, x, y );

void
Wx_DC::DrawLine( x1, y1, x2, y2 )
    wxCoord x1
    wxCoord y1
    wxCoord x2
    wxCoord y2

void
Wx_DC::DrawLines( list, xoffset = 0, yoffset = 0 )
    SV* list
    wxCoord xoffset
    wxCoord yoffset
  PREINIT:
    wxList points;
    wxPoint* pts;
  CODE:
    _get_pointarray( list, &points, &pts );
    THIS->DrawLines( &points, xoffset, yoffset );
    delete [] pts;

#if WXPERL_W_VERSION_GE( 2, 3 )

void
Wx_DC::DrawObject( object )
    Wx_DrawObject* object

#endif

void
Wx_DC::DrawPoint( x, y )
    wxCoord x
    wxCoord y

void
Wx_DC::DrawPolygon( list, xoffset, yoffset, fill_style = wxODDEVEN_RULE )
    SV* list
    wxCoord xoffset
    wxCoord yoffset
    int fill_style
  PREINIT:
    wxList points;
    wxPoint* pts;
  CODE:
    _get_pointarray( list, &points, &pts );
    THIS->DrawPolygon( &points, xoffset, yoffset, fill_style );
    delete [] pts;


void
Wx_DC::DrawRectangle( x, y, width, height )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height

void
Wx_DC::DrawRotatedText( text, x, y, angle )
    wxString text
    wxCoord x
    wxCoord y
    double angle

void
Wx_DC::DrawRoundedRectangle( x, y, width, height, radius = 20 )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height
    wxCoord radius

void
Wx_DC::DrawSpline( list )
    SV* list
  PREINIT:
    wxList points;
    wxPoint* pts;
    int n;
  CODE:
    n = _get_pointarray( list, &points, &pts );
    THIS->DrawSpline( &points );
    delete [] pts;

 #    for( i = 1; i < items; ++i )
 #    {
 #      points.Append( (wxObject*)_sv_2_object( ST(i), "Wx::Point" ) );
 #    }
 #    THIS->DrawSpline( &points );

void
Wx_DC::DrawText( text, x, y )
    wxString text
    wxCoord x
    wxCoord y

void
Wx_DC::EndDoc()

void
Wx_DC::EndDrawing()

void
Wx_DC::EndPage()

void
Wx_DC::FloodFill( x, y, colour, style =  wxFLOOD_SURFACE )
    wxCoord x
    wxCoord y
    Wx_Colour* colour
    int style
  CODE:
    THIS->FloodFill( x, y, *colour, style );

Wx_Brush*
Wx_DC::GetBackground()
  CODE:
    RETVAL = new wxBrush( THIS->GetBackground() );

int
Wx_DC::GetBackgroundMode()

Wx_Brush*
Wx_DC::GetBrush()
  CODE:
    RETVAL = new wxBrush( THIS->GetBrush() );

wxCoord
Wx_DC::GetCharHeight()

wxCoord
Wx_DC::GetCharWidth()

void
Wx_DC::GetClippingBox()
  PREINIT:
    wxCoord x, y, width, height;
  PPCODE:
    THIS->GetClippingBox( &x, &y, &width, &height );
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );
    PUSHs( sv_2mortal( newSViv( width ) ) );
    PUSHs( sv_2mortal( newSViv( height ) ) );

Wx_Font*
Wx_DC::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );

int
Wx_DC::GetLogicalFunction()

int
Wx_DC::GetMapMode()

bool
Wx_DC::GetOptimization()

Wx_Pen*
Wx_DC::GetPen()
  CODE:
    RETVAL = new wxPen( THIS->GetPen() );

Wx_Colour*
Wx_DC::GetPixel( x, y )
    wxCoord x
    wxCoord y
  PREINIT:
    wxColour c;
  CODE:
    THIS->GetPixel( x, y, &c );
    RETVAL = new wxColour( c );
  OUTPUT:
    RETVAL

Wx_Size*
Wx_DC::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );

void
Wx_DC::GetSizeWH()
  PREINIT:
    wxCoord x, y;
  PPCODE:
    THIS->GetSize( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

Wx_Colour*
Wx_DC::GetTextBackground()
  CODE:
    RETVAL = new wxColour( THIS->GetTextBackground() );

void
Wx_DC::GetTextExtent( string, font = 0 )
    wxString string
    Wx_Font* font
  PREINIT:
    wxCoord x;
    wxCoord y;
    wxCoord descent;
    wxCoord externalLeading;
  CODE:
    THIS->GetTextExtent( string, &x, &y, &descent, &externalLeading,
        font );
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );
    PUSHs( sv_2mortal( newSViv( descent ) ) );
    PUSHs( sv_2mortal( newSViv( externalLeading ) ) );

Wx_Colour*
Wx_DC::GetTextForeground()
  CODE:
    RETVAL = new wxColour( THIS->GetTextForeground() );

void
Wx_DC::GetUserScale()
  PREINIT:
    double x, y;
  PPCODE:
    THIS->GetUserScale( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSVnv( x ) ) );
    PUSHs( sv_2mortal( newSVnv( y ) ) );

wxCoord
Wx_DC::LogicalToDeviceX( x )
    wxCoord x

wxCoord
Wx_DC::LogicalToDeviceXRel( x )
    wxCoord x

wxCoord
Wx_DC::LogicalToDeviceY( y )
    wxCoord y

wxCoord
Wx_DC::LogicalToDeviceYRel( y )
    wxCoord y

wxCoord
Wx_DC::MaxX()

wxCoord
Wx_DC::MaxY()

wxCoord
Wx_DC::MinX()

wxCoord
Wx_DC::MinY()

bool
Wx_DC::Ok()

void
Wx_DC::ResetBoundingBox()

void
Wx_DC::SetDeviceOrigin( x, y )
    wxCoord x
    wxCoord y

void
Wx_DC::SetBackground( brush )
    Wx_Brush* brush
  CODE:
    THIS->SetBackground( *brush );

void
Wx_DC::SetBackgroundMode( mode )
    int mode

void
Wx_DC::SetBrush( brush )
    Wx_Brush* brush
  CODE:
    THIS->SetBrush( *brush );

void
Wx_DC::SetClippingRegionXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    THIS->SetClippingRegion( x, y, w, h );

void
Wx_DC::SetClippingRegionRegion( region )
    Wx_Region* region
  CODE:
    THIS->SetClippingRegion( *region );

void
Wx_DC::SetFont( font )
    Wx_Font* font
  CODE:
    THIS->SetFont( *font );

void
Wx_DC::SetLogicalFunction( function )
    int function

void
Wx_DC::SetMapMode( mode )
    int mode

void
Wx_DC::SetOptimization( optimize )
    bool optimize

void
Wx_DC::SetPalette( palette )
    Wx_Palette* palette
  CODE:
    THIS->SetPalette( *palette );

void
Wx_DC::SetPen( pen )
    Wx_Pen* pen
  CODE:
    THIS->SetPen( *pen );

void
Wx_DC::SetTextBackground( colour )
    Wx_Colour* colour
  CODE:
    THIS->SetTextBackground( *colour );

void
Wx_DC::SetTextForeground( colour )
    Wx_Colour* colour
  CODE:
    THIS->SetTextForeground( *colour );

void
Wx_DC::SetUserScale( xScale, yScale )
    double xScale
    double yScale

bool
Wx_DC::StartDoc( message )
    wxString message

void
Wx_DC::StartPage()

MODULE=Wx PACKAGE=Wx::ScreenDC

Wx_ScreenDC*
Wx_ScreenDC::new()

bool
Wx_ScreenDC::EndDrawingOnTop()

bool
Wx_ScreenDC::StartDrawingOnTopWindow( window )
    Wx_Window* window
  CODE:
    RETVAL = THIS->StartDrawingOnTop( window );
  OUTPUT:
    RETVAL

bool
Wx_ScreenDC::StartDrawingOnTopRect( rect )
    Wx_Rect* rect
  CODE:
    RETVAL = THIS->StartDrawingOnTop( rect );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::WindowDC

Wx_WindowDC*
Wx_WindowDC::new( window )
    Wx_Window* window

MODULE=Wx PACKAGE=Wx::PaintDC

Wx_PaintDC*
Wx_PaintDC::new( window )
    Wx_Window* window

MODULE=Wx PACKAGE=Wx::MemoryDC

Wx_MemoryDC*
Wx_MemoryDC::new()

void
Wx_MemoryDC::SelectObject( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    THIS->SelectObject( *bitmap );

MODULE=Wx PACKAGE=Wx::ClientDC

Wx_ClientDC*
Wx_ClientDC::new( window )
    Wx_Window* window
