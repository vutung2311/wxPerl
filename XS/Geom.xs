#############################################################################
## Name:        XS/Geom.xs
## Purpose:     XS for Wx::Point, Wx::Size, Wx::Rect, Wx::Region
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Geom.xs,v 1.17 2005/07/14 21:01:51 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Size

wxSize*
wxSize::new( width = 0, height = 0 )
    int width
    int height

void
wxSize::DESTROY()

int
wxSize::width( ... )
  CODE:
    if( items > 1 )
      THIS->x = SvIV( ST(1) );
    RETVAL = THIS->x;
  OUTPUT:
    RETVAL

int
wxSize::height( ... )
  CODE:
    if( items > 1 )
      THIS->y = SvIV( ST(1) );
    RETVAL = THIS->y;
  OUTPUT:
    RETVAL

int
wxSize::GetHeight()

int
wxSize::GetWidth()

void
wxSize::Set( width, height )
    int width
    int height

void
wxSize::SetHeight( height )
    int height

void
wxSize::SetWidth( width )
    int width

MODULE=Wx PACKAGE=Wx::Point

wxPoint*
wxPoint::new( x = 0, y = 0 )
    int x
    int y

void
wxPoint::DESTROY()

int
wxPoint::x( ... )
  CODE:
    if( items > 1 )
      THIS->x = SvIV( ST(1) );
    RETVAL = THIS->x;
  OUTPUT:
    RETVAL

int
wxPoint::y( ... )
  CODE:
    if( items > 1 )
      THIS->y = SvIV( ST(1) );
    RETVAL = THIS->y;
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::Rect

void
wxRect::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, newXYWH )
        MATCH_REDISP( wxPliOvl_wpoi_wsiz, newPS )
        MATCH_REDISP( wxPliOvl_wpoi_wpoi, newPP )
    END_OVERLOAD( Wx::Rect::new )

wxRect*
newXYWH( CLASS, x, y, width, height )
    SV* CLASS
    int x
    int y
    int width
    int height
  CODE:
    RETVAL = new wxRect( x, y, width, height );
  OUTPUT:
    RETVAL

wxRect*
newPP( CLASS, tl, br )
    SV* CLASS
    wxPoint tl
    wxPoint br
  CODE:
    RETVAL = new wxRect( tl, br );
  OUTPUT:
    RETVAL

wxRect*
newPS( CLASS, pos, size )
    SV* CLASS
    wxPoint pos
    wxSize size
  CODE:
    RETVAL = new wxRect( pos, size );
  OUTPUT:
    RETVAL

void
wxRect::DESTROY()

int
wxRect::x( ... )
  CODE:
    if( items > 1 )
      THIS->x = SvIV( ST(1) );
    RETVAL = THIS->x;
  OUTPUT:
    RETVAL

int
wxRect::y( ... )
  CODE:
    if( items > 1 )
      THIS->y = SvIV( ST(1) );
    RETVAL = THIS->y;
  OUTPUT:
    RETVAL

int
wxRect::width( ... )
  CODE:
    if( items > 1 )
      THIS->width = SvIV( ST(1) );
    RETVAL = THIS->width;
  OUTPUT:
    RETVAL

int
wxRect::height( ... )
  CODE:
    if( items > 1 )
      THIS->height = SvIV( ST(1) );
    RETVAL = THIS->height;
  OUTPUT:
    RETVAL

int
wxRect::GetBottom()

int
wxRect::GetHeight()

int
wxRect::GetLeft()

wxPoint*
wxRect::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

int
wxRect::GetRight()

wxSize*
wxRect::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

int
wxRect::GetTop()

int
wxRect::GetWidth()

int
wxRect::GetX()

int
wxRect::GetY()

void
wxRect::Inflate( x, y )
    wxCoord x 
    wxCoord y = NO_INIT
  CODE:
    if( items == 2 )
      y = x;
    else
      y = SvIV( ST(2) );
    THIS->Inflate( x, y );

void
wxRect::SetHeight( height )
    int height

void
wxRect::SetWidth( width )
    int width

void
wxRect::SetX( x )
    int x

void
wxRect::SetY( y )
   int y

void
wxRect::SetPosition( pos )
    wxPoint pos

void
wxRect::SetSize( size )
    wxSize size

MODULE=Wx PACKAGE=Wx::Region

wxRegion*
newEmpty( CLASS )
    SV* CLASS
  CODE:
    RETVAL = new wxRegion();
  OUTPUT:
    RETVAL

wxRegion*
newXYWH( CLASS, x, y, width, height )
    SV* CLASS
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height
  CODE:
    RETVAL = new wxRegion( x, y, width, height );
  OUTPUT:
    RETVAL

wxRegion*
newPP( CLASS, topLeft, bottomRight )
    SV* CLASS
    wxPoint topLeft
    wxPoint bottomRight
  CODE:
    RETVAL = new wxRegion( topLeft, bottomRight );
  OUTPUT:
    RETVAL

wxRegion*
newRect( CLASS, rect )
    SV* CLASS
    wxRect* rect
  CODE:
    RETVAL = new wxRegion( *rect );
  OUTPUT:
    RETVAL

#if !defined( __WXMAC__ ) && !defined( __WXMOTIF__ )

wxRegion*
newPolygon( CLASS, list, fillStyle = wxODDEVEN_RULE )
    SV* CLASS
    SV* list
    int fillStyle
  PREINIT:
    wxPoint* points;
    size_t n;
  CODE:
    n = wxPli_av_2_pointarray( aTHX_ list, &points );
    RETVAL = new wxRegion( n, points, fillStyle );
    delete [] points;
  OUTPUT: RETVAL

#endif

wxRegion*
newBitmap( CLASS, bitmap, colour = wxNullColour, tolerance = 0 )
    SV* CLASS
    wxBitmap* bitmap
    wxColour colour
    int tolerance
  CODE:
    RETVAL = new wxRegion( *bitmap, colour, tolerance );
  OUTPUT: RETVAL

void
wxRegion::DESTROY()

void
wxRegion::Clear()

wxRegionContain
wxRegion::ContainsXY( x, y )
    wxCoord x
    wxCoord y
  CODE:
    RETVAL = THIS->Contains( x, y );
  OUTPUT:
    RETVAL

wxRegionContain
wxRegion::ContainsPoint( point )
    wxPoint point
  CODE:
    RETVAL = THIS->Contains( point );
  OUTPUT:
    RETVAL

wxRegionContain
wxRegion::ContainsXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    RETVAL = THIS->Contains( x, y, w, h );
  OUTPUT:
    RETVAL

wxRegionContain
wxRegion::ContainsRect( rect )
    wxRect* rect
  CODE:
    RETVAL = THIS->Contains( *rect );
  OUTPUT:
    RETVAL

wxRect*
wxRegion::GetBox()
  CODE:
    RETVAL = new wxRect( THIS->GetBox() );
  OUTPUT:
    RETVAL

void
wxRegion::GetBoxXYWH()
  PREINIT:
    int x;
    int y;
    int w;
    int h;
  PPCODE:
    THIS->GetBox( x, y, w, h );
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSViv( (IV) x ) ) );
    PUSHs( sv_2mortal( newSViv( (IV) y ) ) );
    PUSHs( sv_2mortal( newSViv( (IV) w ) ) );
    PUSHs( sv_2mortal( newSViv( (IV) h ) ) );

bool
wxRegion::IntersectXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    RETVAL = THIS->Intersect( x, y, w, h );
  OUTPUT:
    RETVAL

bool
wxRegion::IntersectRect( rect )
    wxRect* rect
  CODE:
    RETVAL = THIS->Intersect( *rect );
  OUTPUT:
    RETVAL

bool
wxRegion::IntersectRegion( region )
    wxRegion* region
  CODE:
    RETVAL = THIS->Intersect( *region );
  OUTPUT:
    RETVAL

bool
wxRegion::IsEmpty()

bool
wxRegion::SubtractRect( rect )
    wxRect* rect
  CODE:
    RETVAL = THIS->Subtract( *rect );
  OUTPUT:
    RETVAL

#if !defined(__WXMOTIF__) && !defined(__WXMAC__)

bool
wxRegion::Offset( x, y )
    wxCoord x
    wxCoord y

#endif

bool
wxRegion::SubtractRegion( region )
    wxRegion* region
  CODE:
    RETVAL = THIS->Subtract( *region );
  OUTPUT:
    RETVAL

bool
wxRegion::UnionXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    RETVAL = THIS->Union( x, y, w, h );
  OUTPUT:
    RETVAL

bool
wxRegion::UnionRect( rect )
    wxRect* rect
  CODE:
    RETVAL = THIS->Union( *rect );
  OUTPUT:
    RETVAL

bool
wxRegion::UnionRegion( region )
    wxRegion* region
  CODE:
    RETVAL = THIS->Union( *region );
  OUTPUT:
    RETVAL

bool
wxRegion::XorXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    RETVAL = THIS->Xor( x, y, w, h );
  OUTPUT:
    RETVAL

bool
wxRegion::XorRect( rect )
    wxRect* rect
  CODE:
    RETVAL = THIS->Xor( *rect );
  OUTPUT:
    RETVAL

bool
wxRegion::XorRegion( region )
    wxRegion* region
  CODE:
    RETVAL = THIS->Xor( *region );
  OUTPUT:
    RETVAL
