/////////////////////////////////////////////////////////////////////////////
// Name:        XS/Region.xs
// Purpose:     XS for Wx::Region
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id$
// Copyright:   (c) 2000-2003, 2006-2010 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT
#include "cpp/wxapi.h"
#include "cpp/overload.h"
#include <wx/region.h>
#include <wx/bitmap.h>
#include <wx/colour.h>

// delayload

MODULE=Wx_Region PACKAGE=Wx::Region

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
    wxPolygonFillMode fillStyle
  PREINIT:
    wxPoint* points;
    size_t n;
  CODE:
    n = wxPli_av_2_pointarray( aTHX_ list, &points );
    RETVAL = new wxRegion( n, points, fillStyle );
    delete [] points;
  OUTPUT: RETVAL

#endif

#if !defined( __WXOSX_COCOA__ )

wxRegion*
newBitmap( CLASS, bitmap, colour, tolerance = 0 )
    SV* CLASS
    wxBitmap* bitmap
    wxColour colour
    int tolerance
  CODE: 
    RETVAL = new wxRegion( *bitmap, colour, tolerance );
  OUTPUT: RETVAL

wxRegion*
newBitmapOnly( CLASS, bitmap )
    SV* CLASS
    wxBitmap* bitmap
  CODE:
    RETVAL = new wxRegion( *bitmap );
  OUTPUT: RETVAL

#endif

void
wxRegion::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newEmpty )
        MATCH_REDISP( wxPliOvl_n_n_n_n, newXYWH )
        MATCH_REDISP( wxPliOvl_wpoi_wpoi, newPP )
        MATCH_REDISP( wxPliOvl_wrec, newRect )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wbmp_wcol_n, newBitmap, 2 )
        MATCH_REDISP( wxPliOvl_wbmp, newBitmapOnly )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_arr, newPolygon, 1 )
    END_OVERLOAD( Wx::Region::new )

static void
wxRegion::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxRegion::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Region", THIS, ST(0) );
    delete THIS;

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

void
wxRegion::Contains( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, ContainsXYWH )
        MATCH_REDISP( wxPliOvl_n_n, ContainsXY )
        MATCH_REDISP( wxPliOvl_wpoi, ContainsPoint )
        MATCH_REDISP( wxPliOvl_wrec, ContainsRect )
    END_OVERLOAD( Wx::Region::Contains )

wxBitmap*
wxRegion::ConvertToBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->ConvertToBitmap() );
  OUTPUT: RETVAL

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

void
wxRegion::Intersect( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, IntersectXYWH )
        MATCH_REDISP( wxPliOvl_wrec, IntersectRect )
        MATCH_REDISP( wxPliOvl_wreg, IntersectRegion )
    END_OVERLOAD( Wx::Region::Intersect )

bool
wxRegion::IsEmpty()

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

bool
wxRegion::IsEqual( region )
    wxRegion* region
  C_ARGS: *region

#endif

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

void
wxRegion::Subtract( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wrec, SubtractRect )
        MATCH_REDISP( wxPliOvl_wreg, SubtractRegion )
    END_OVERLOAD( Wx::Region::Subtract )

bool
wxRegion::UnionXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    RETVAL = THIS->Union( x, y, w, h );
  OUTPUT: RETVAL

bool
wxRegion::UnionRect( rect )
    wxRect* rect
  CODE:
    RETVAL = THIS->Union( *rect );
  OUTPUT: RETVAL

bool
wxRegion::UnionRegion( region )
    wxRegion* region
  CODE:
    RETVAL = THIS->Union( *region );
  OUTPUT: RETVAL

bool
wxRegion::UnionBitmapOnly( bitmap )
    wxBitmap* bitmap
  CODE:
    RETVAL = THIS->Union( *bitmap );
  OUTPUT: RETVAL

bool
wxRegion::UnionBitmap( bitmap, colour, tolerance = 0 )
    wxBitmap* bitmap
    wxColour colour
    int tolerance
  CODE:
    RETVAL = THIS->Union( *bitmap, colour, tolerance );
  OUTPUT: RETVAL

void
wxRegion::Union( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, UnionXYWH )
        MATCH_REDISP( wxPliOvl_wrec, UnionRect )
        MATCH_REDISP( wxPliOvl_wreg, UnionRegion )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wbmp_wcol_n, UnionBitmap, 2 )
        MATCH_REDISP( wxPliOvl_wbmp, UnionBitmapOnly )
    END_OVERLOAD( Wx::Region::Union )

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

void
wxRegion::Xor( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, XorXYWH )
        MATCH_REDISP( wxPliOvl_wrec, XorRect )
        MATCH_REDISP( wxPliOvl_wreg, XorRegion )
    END_OVERLOAD( Wx::Region::Xor )
