/////////////////////////////////////////////////////////////////////////////
// Name:        Window.xs
// Purpose:     XS for Wx::Window
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: Window.xs,v 1.54 2005/01/04 17:14:34 mbarbon Exp $
// Copyright:   (c) 2000-2002, 2004-2005 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/typedef.h"

#include <wx/window.h>
#include <wx/layout.h>
#include <wx/sizer.h>

#include "cpp/overload.h"

#if wxPERL_USE_TOOLTIPS
#include <wx/tooltip.h>
#endif

#undef THIS

#include "cpp/v_cback.h"
#include "cpp/window.h"

WXPLI_BOOT_ONCE(Wx_Win);
#define boot_Wx_Win wxPli_boot_Wx_Win

MODULE=Wx_Win PACKAGE=Wx PREFIX=wx

wxPoint*
wxGetMousePosition()
  PREINIT:
    int x, y;
  CODE:
    ::wxGetMousePosition( &x, &y );
    RETVAL = new wxPoint( x, y );
  OUTPUT:
    RETVAL

wxWindow*
wxGetTopLevelParent( window )
    wxWindow* window

wxWindow*
wxFindWindowAtPointer( pt )
    wxPoint pt

wxWindow*
wxGetActiveWindow()

MODULE=Wx_Win PACKAGE=Wx::Window

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::Window::new" )

wxWindow*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxPliWindow( CLASS );
  OUTPUT: RETVAL

wxWindow*
newFull( CLASS, parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0 , name = wxPanelNameStr )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliWindow( CLASS, parent, id, pos, size, style, name );
  OUTPUT: RETVAL

bool
wxWindow::Create( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0 , name = wxPanelNameStr)
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name

void
wxWindow::CaptureMouse()

void
wxWindow::Centre( direction = wxBOTH )
    int direction

void
wxWindow::CentreOnParent( direction = wxBOTH )
    int direction

void
wxWindow::CentreOnScreen( direction = wxBOTH )
    int direction

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

void
wxWindow::ClearBackground()

#else

void
wxWindow::Clear()

#endif

void
wxWindow::ClientToScreen( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n, ClientToScreenXY )
        MATCH_REDISP( wxPliOvl_wpoi, ClientToScreenPoint )
    END_OVERLOAD( Wx::Window::ClientToScreen )

wxPoint*
wxWindow::ClientToScreenPoint( point )
    wxPoint point
  CODE:
    RETVAL = new wxPoint( THIS->ClientToScreen( point ) );
  OUTPUT:
    RETVAL

void
wxWindow::ClientToScreenXY( x, y )
    int x
    int y
  PPCODE:
    THIS->ClientToScreen( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

bool
wxWindow::Close( force = false )
    bool force

void
wxWindow::ConvertDialogToPixels( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wpoi, ConvertDialogPointToPixels )
        MATCH_REDISP( wxPliOvl_wsiz, ConvertDialogSizeToPixels )
    END_OVERLOAD( Wx::Window::ConvertDialogToPixels )

wxPoint*
wxWindow::ConvertDialogPointToPixels( point )
    wxPoint point
  CODE:
    RETVAL = new wxPoint( THIS->ConvertDialogToPixels( point ) );
  OUTPUT:
    RETVAL

wxSize*
wxWindow::ConvertDialogSizeToPixels( size )
    wxSize size
  CODE:
    RETVAL = new wxSize( THIS->ConvertDialogToPixels( size ) );
  OUTPUT:
    RETVAL

void
wxWindow::ConvertPixelsToDialog( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wpoi, ConvertPixelsPointToDialog )
        MATCH_REDISP( wxPliOvl_wsiz, ConvertPixelsSizeToDialog )
    END_OVERLOAD( Wx::Window::ConvertPixelsToDialog )

wxPoint*
wxWindow::ConvertPixelsPointToDialog( point )
    wxPoint point
  CODE:
    RETVAL = new wxPoint( THIS->ConvertPixelsToDialog( point ) );
  OUTPUT:
    RETVAL

wxSize*
wxWindow::ConvertPixelsSizeToDialog( size )
    wxSize size
  CODE:
    RETVAL = new wxSize( THIS->ConvertPixelsToDialog( size ) );
  OUTPUT:
    RETVAL

bool
wxWindow::Destroy()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
wxWindow::DragAcceptFiles( accept )
    bool accept

#endif // __WXMSW__

void
wxWindow::Enable( enable )
    bool enable

wxWindow*
FindFocus()
  CODE:
    RETVAL = wxWindow::FindFocus();
  OUTPUT:
    RETVAL

wxWindow*
wxWindow::FindWindow( i )
    SV* i
  CODE:
    if( looks_like_number( i ) ) {
      int id = SvIV( i );
      RETVAL = THIS->FindWindow( id );
    }
    else {
      wxString name;
      WXSTRING_INPUT( name, const char*, i );
      RETVAL = THIS->FindWindow( name );
    }
  OUTPUT:
    RETVAL

wxWindow*
FindWindowById( id, parent = NULL )
    wxWindowID id
    wxWindow* parent
  CODE:
    RETVAL = wxWindow::FindWindowById( id, parent );
  OUTPUT:
    RETVAL

wxWindow*
FindWindowByName( id, parent = NULL )
    wxString id
    wxWindow* parent
  CODE:
    RETVAL = wxWindow::FindWindowByName( id, parent );
  OUTPUT:
    RETVAL

wxWindow*
FindWindowByLabel( id, parent = NULL )
    wxString id
    wxWindow* parent
  CODE:
    RETVAL = wxWindow::FindWindowByLabel( id, parent );
  OUTPUT:
    RETVAL


void
wxWindow::Fit()

void
wxWindow::FitInside()

void
wxWindow::Freeze()

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

wxBackgroundStyle
wxWindow::GetBackgroundStyle()

#endif

wxColour*
wxWindow::GetBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetBackgroundColour() );
  OUTPUT:
    RETVAL

wxSize*
wxWindow::GetBestSize()
  CODE:
    RETVAL = new wxSize( THIS->GetBestSize() );
  OUTPUT:
    RETVAL

wxCaret*
wxWindow::GetCaret()

int
wxWindow::GetCharHeight()

int
wxWindow::GetCharWidth()

void
wxWindow::GetChildren()
  PPCODE:
    const wxWindowList& list = THIS->GetChildren();
    wxWindowListNode* node;
    
    EXTEND( SP, (IV) list.GetCount() );

    for( node = list.GetFirst(); node; node = node->GetNext() )
      PUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(), node->GetData() ) );

wxSize*
wxWindow::GetClientSize()
  CODE:
    RETVAL = new wxSize( THIS->GetClientSize() );
  OUTPUT:
    RETVAL

void
wxWindow::GetClientSizeXY()
  PREINIT:
    int x;
    int y;
  PPCODE:
    THIS->GetClientSize( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

wxSizer*
wxWindow::GetContainingSizer()

#if wxPERL_USE_DRAG_AND_DROP

wxDropTarget*
wxWindow::GetDropTarget()
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), false );

#endif

wxWindow*
wxWindow::GetDefaultItem()

wxEvtHandler*
wxWindow::GetEventHandler()

long
wxWindow::GetExtraStyle()

wxFont*
wxWindow::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );
  OUTPUT:
    RETVAL

wxColour*
wxWindow::GetForegroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetForegroundColour() );
  OUTPUT:
    RETVAL

wxWindow*
wxWindow::GetGrandParent()

#if WXPERL_W_VERSION_GE( 2, 5, 1 ) && defined( __WXMSW__ )

void*
wxWindow::GetHandle()

#else

IV
wxWindow::GetHandle()
  CODE:
#ifdef __WXMSW__
    WXHWND handle = THIS->GetHandle();
    RETVAL = handle;
#else
    WXWidget handle = THIS->GetHandle();
    RETVAL = PTR2IV(handle);
#endif
  OUTPUT:
    RETVAL

#endif

wxString
wxWindow::GetHelpText()

int
wxWindow::GetId()

wxString
wxWindow::GetLabel()

wxLayoutConstraints*
wxWindow::GetConstraints()

wxString
wxWindow::GetName()

wxWindow*
wxWindow::GetParent()

wxPoint*
wxWindow::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

void
wxWindow::GetPositionXY()
  PREINIT:
    int x;
    int y;
  PPCODE:
    THIS->GetPosition( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( (IV) x ) ) );
    PUSHs( sv_2mortal( newSViv( (IV) y ) ) );

wxRect*
wxWindow::GetRect()
  CODE:
    RETVAL = new wxRect( THIS->GetRect() );
  OUTPUT:
    RETVAL

int
wxWindow::GetScrollThumb( orientation )
    int orientation

int
wxWindow::GetScrollPos( orientation )
    int orientation

int
wxWindow::GetScrollRange( orientation )
    int orientation

wxSize*
wxWindow::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

wxSizer*
wxWindow::GetSizer()

void
wxWindow::GetSizeWH()
  PREINIT:
    int x;
    int y;
  PPCODE:
    THIS->GetSize( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( (IV) x ) ) );
    PUSHs( sv_2mortal( newSViv( (IV) y ) ) );

void
wxWindow::GetTextExtent( string, font = 0 )
    wxString string
    wxFont* font
  PREINIT:
    int x;
    int y;
    int descent;
    int externalLeading;
  PPCODE:
    THIS->GetTextExtent( string, &x, &y, &descent, &externalLeading,
        font );
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );
    PUSHs( sv_2mortal( newSViv( descent ) ) );
    PUSHs( sv_2mortal( newSViv( externalLeading ) ) );

wxString
wxWindow::GetTitle()

#if wxPERL_USE_TOOLTIPS

wxToolTip*
wxWindow::GetToolTip()

#endif

wxRegion*
wxWindow::GetUpdateRegion()
  CODE:
    RETVAL = new wxRegion( THIS->GetUpdateRegion() );
  OUTPUT:
    RETVAL

wxValidator*
wxWindow::GetValidator()

long
wxWindow::GetWindowStyleFlag()

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

void
wxWindow::InheritAttributes()

#endif

bool
wxWindow::IsEnabled()

void
wxWindow::IsExposed( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wpoi, IsExposedPoint )
        MATCH_REDISP( wxPliOvl_wrec, IsExposedRect )
        MATCH_REDISP( wxPliOvl_n_n_n_n, IsExposedXYWH )
    END_OVERLOAD( Wx::Window::IsExposed )

bool
wxWindow::IsExposedXYWH( x, y, w = 0, h = 0 )
    int x
    int y
    int w
    int h
  CODE:
    RETVAL = THIS->IsExposed( x, y, w, h );
  OUTPUT:
    RETVAL

bool
wxWindow::IsExposedPoint( point )
    wxPoint point
  CODE:
    RETVAL = THIS->IsExposed( point );
  OUTPUT:
    RETVAL

bool
wxWindow::IsExposedRect( rect )
    wxRect* rect
  CODE:
    RETVAL = THIS->IsExposed( *rect );
  OUTPUT:
    RETVAL

bool
wxWindow::IsRetained()

bool
wxWindow::IsShown()

bool
wxWindow::IsTopLevel()

void
wxWindow::Layout()

void
wxWindow::Lower()

void
wxWindow::MakeModal( flag )
    bool flag

void
wxWindow::Move( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wpoi, MovePoint )
        MATCH_REDISP( wxPliOvl_n_n, MoveXY )
    END_OVERLOAD( Wx::Window::Move )

void
wxWindow::MoveXY( x, y )
    int x
    int y
  CODE:
    THIS->Move( x, y );

void
wxWindow::MovePoint( point )
    wxPoint point
  CODE:
    THIS->Move( point );

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

void
wxWindow::MoveBeforeInTabOrder( window )
    wxWindow* window

void
wxWindow::MoveAfterInTabOrder( window )
    wxWindow* window

#endif

wxEvtHandler*
wxWindow::PopEventHandler( deleteHandler )
    bool deleteHandler

void
wxWindow::PopupMenu( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wmen_wpoi, PopupMenuPoint )
        MATCH_REDISP( wxPliOvl_wmen_n_n, PopupMenuXY )
    END_OVERLOAD( Wx::Window::PopupMenu )

bool
wxWindow::PopupMenuPoint( menu, point )
    wxMenu* menu
    wxPoint point
  CODE:
    RETVAL = THIS->PopupMenu( menu, point );
  OUTPUT:
    RETVAL

bool
wxWindow::PopupMenuXY( menu, x, y )
    wxMenu* menu
    int x
    int y
  CODE:
    RETVAL = THIS->PopupMenu( menu, x, y );
  OUTPUT:
    RETVAL

void
wxWindow::PushEventHandler( handler )
    wxEvtHandler* handler

void
wxWindow::Raise()

void
wxWindow::Refresh( eraseBackground = true, rect = 0 )
    bool eraseBackground
    wxRect* rect

void
wxWindow::ReleaseMouse()

bool
wxWindow::RemoveEventHandler( handler )
    wxEvtHandler* handler

bool
wxWindow::Reparent( newParent )
    wxWindow* newParent

void
wxWindow::ScreenToClient( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n, ScreenToClientXY )
        MATCH_REDISP( wxPliOvl_wpoi, ScreenToClientPoint )
    END_OVERLOAD( Wx::Window::ScreenToClient )

wxPoint*
wxWindow::ScreenToClientPoint( point )
    wxPoint point
  CODE:
    RETVAL = new wxPoint( THIS->ScreenToClient( point ) );
  OUTPUT:
    RETVAL

void
wxWindow::ScreenToClientXY( x, y )
    int x
    int y
  PPCODE:
    THIS->ScreenToClient( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( (IV) x ) ) );
    PUSHs( sv_2mortal( newSViv( (IV) y ) ) );

bool
wxWindow::ScrollLines( lines )
    int lines

bool
wxWindow::ScrollPages( lines )
    int lines

void
wxWindow::ScrollWindow( x, y, rect = 0 )
    int x
    int y
    wxRect* rect

void
wxWindow::SetAcceleratorTable( accel )
    wxAcceleratorTable* accel
  CODE:
    THIS->SetAcceleratorTable( *accel );

void
wxWindow::SetAutoLayout( autoLayout )
    bool autoLayout

#ifdef __WXGTK__

void
wxWindow::SetThemeEnabled( themeEnabled )
     bool themeEnabled

#endif

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

bool
wxWindow::SetBackgroundStyle( style )
    wxBackgroundStyle style

#endif

void
wxWindow::SetBackgroundColour( colour )
    wxColour* colour
  CODE:
    THIS->SetBackgroundColour( *colour );

void
wxWindow::SetCaret( caret )
    wxCaret* caret

void
wxWindow::SetClientSize( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wsiz, SetClientSizeSize )
        MATCH_REDISP( wxPliOvl_n_n, SetClientSizeWH )
    END_OVERLOAD( Wx::Window::SetClientSize )

void
wxWindow::SetClientSizeSize( size )
    wxSize size
  CODE:
    THIS->SetClientSize( size );

void
wxWindow::SetClientSizeWH( width, height )
    int width
    int height
  CODE:
    THIS->SetClientSize( width, height );

void
wxWindow::SetConstraints( constraints )
    wxLayoutConstraints* constraints

void
wxWindow::SetContainingSizer( sizer )
    wxSizer* sizer

void
wxWindow::SetCursor( cursor )
    wxCursor* cursor
  CODE:
    THIS->SetCursor( *cursor );

wxWindow*
wxWindow::SetDefaultItem( window )
    wxWindow* window

#if wxPERL_USE_DRAG_AND_DROP

void
wxWindow::SetDropTarget( target )
    wxDropTarget* target
  CODE:
    wxPli_object_set_deleteable( aTHX_ ST(1), false );
    THIS->SetDropTarget( target );

#endif

void
wxWindow::SetEventHandler( handler )
    wxEvtHandler* handler

void
wxWindow::SetExtraStyle( style )
    long style

void
wxWindow::SetFocus()

void
wxWindow::SetForegroundColour( colour )
    wxColour* colour
  CODE:
    THIS->SetForegroundColour( *colour );

void
wxWindow::SetHelpText( text )
    wxString text

void
wxWindow::SetHelpTextForId( text )
    wxString text

void
wxWindow::SetId( id )
    int id

void
wxWindow::SetLabel( label )
    wxString label

void
wxWindow::SetName( name )
    wxString name

void
wxWindow::SetScrollbar( orientation, position, thumbSize, range, refresh = true )
    int orientation
    int position
    int thumbSize
    int range
    bool refresh

void
wxWindow::SetScrollPos( orientation, position, refresh = true )
    int orientation
    int position
    bool refresh

void
wxWindow::SetFont( font )
    wxFont* font
  CODE:
    THIS->SetFont( *font );

void
wxWindow::SetSize( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_n_n_n, SetSizeXYWHF, 4 )
        MATCH_REDISP( wxPliOvl_n_n, SetSizeWH )
        MATCH_REDISP( wxPliOvl_wsiz, SetSizeSize )
        MATCH_REDISP( wxPliOvl_wrec, SetSizeRect )
    END_OVERLOAD( Wx::Window::SetSize )

void
wxWindow::SetSizeSize( size )
    wxSize size
  CODE:
    THIS->SetSize( size );

void
wxWindow::SetSizeRect( rect )
    wxRect* rect
  CODE:
    THIS->SetSize( *rect );

void
wxWindow::SetSizeWH( width, height )
    int width
    int height
  CODE:
    THIS->SetSize( width, height );

void
wxWindow::SetSizeXYWHF( x, y, width, height, flags = wxSIZE_AUTO )
    int x
    int y
    int width
    int height
    int flags
  CODE:
    THIS->SetSize( x, y, width, height, flags );

void
wxWindow::SetSizeHints( minW, minH, maxW = -1, maxH = -1, incW = -1, incH = -1 )
    int minW
    int minH
    int maxW
    int maxH
    int incW
    int incH

void
wxWindow::SetVirtualSizeHints( minW, minH, maxW = -1, maxH = -1 )
    int minW
    int minH
    int maxW
    int maxH

void
wxWindow::SetVirtualSize( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n, SetVirtualSizeXY )
        MATCH_REDISP( wxPliOvl_wsiz, SetVirtualSizeSize )
    END_OVERLOAD( Wx::Window::SetVirtualSize )

void
wxWindow::SetVirtualSizeXY( width, height )
    int width
    int height
  CODE:
    THIS->SetVirtualSize( width, height );

void
wxWindow::SetVirtualSizeSize( size )
    wxSize size
  CODE:
    THIS->SetVirtualSize( size );

void
wxWindow::SetSizer( sizer, deleteOld = true )
    wxSizer* sizer
    bool deleteOld

void
wxWindow::SetSizerAndFit( sizer, deleteOld = true )
    wxSizer* sizer
    bool deleteOld

void
wxWindow::SetTitle( title )
    wxString title

#if wxPERL_USE_TOOLTIPS

void
wxWindow::SetToolTip( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wtip, SetToolTipTip )
        MATCH_REDISP( wxPliOvl_s, SetToolTipString )
    END_OVERLOAD( Wx::Window::SetToolTip )

void
wxWindow::SetToolTipTip( tooltip )
    wxToolTip* tooltip
  CODE:
    THIS->SetToolTip( tooltip );

void
wxWindow::SetToolTipString( string )
    wxString string
  CODE:
    THIS->SetToolTip( string );

#endif

void
wxWindow::SetValidator( validator )
    wxValidator* validator
  CODE:
    THIS->SetValidator( *validator );

void
wxWindow::SetWindowStyle( style )
    long style

void
wxWindow::SetWindowStyleFlag( style )
    long style

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

bool
wxWindow::ShouldInheritColours()

#endif

bool
wxWindow::Show( show )
    bool show

void
wxWindow::Thaw()

bool
wxWindow::TransferDataFromWindow()
  CODE:
    RETVAL = THIS->wxWindow::TransferDataFromWindow();
  OUTPUT:
    RETVAL

bool
wxWindow::TransferDataToWindow()
  CODE:
    RETVAL = THIS->wxWindow::TransferDataToWindow();
  OUTPUT:
    RETVAL

bool
wxWindow::Validate()
  CODE:
    RETVAL = THIS->wxWindow::Validate();
  OUTPUT:
    RETVAL

void
wxWindow::Update()

void
wxWindow::RefreshRect( rect )
    wxRect* rect
  CODE:
    THIS->RefreshRect( *rect );

void
wxWindow::WarpPointer( x, y )
    int x
    int y

INCLUDE: XS/Accelerators.xs

INCLUDE: perl script/xsubppp.pl --typemap typemap.xsp XS/PlWindow.xsp |

INCLUDE: perl script/xsubppp.pl --typemap typemap.xsp XS/SplitterWindow.xs |

INCLUDE: XS/ScrolledWindow.xs
INCLUDE: XS/Validators.xs
INCLUDE: XS/Constraint.xs

INCLUDE: perl script/xsubppp.pl --typemap typemap.xsp XS/Sizer.xs |

INCLUDE: perl script/xsubppp.pl --typemap typemap.xsp XS/GridBagSizer.xsp |

INCLUDE: XS/SashWindow.xs

MODULE=Wx_Win PACKAGE=Wx::Window

