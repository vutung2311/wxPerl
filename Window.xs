/////////////////////////////////////////////////////////////////////////////
// Name:        Window.xs
// Purpose:     XS for Wx::Window
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool

#include <wx/defs.h>

#include <wx/window.h>
#include <wx/layout.h>
#include <wx/sizer.h>
#include <wx/tooltip.h>
#include <wx/splitter.h>
#include <wx/scrolwin.h>
#include <wx/statbox.h>
#include <wx/notebook.h>
#include <wx/validate.h>
#include <wx/dc.h>
#include <stdarg.h>

#undef _

#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#undef bool
#undef Move
#undef Copy

#undef THIS

#if __VISUALC__
#pragma warning (disable: 4800 )
#endif

#include "cpp/helpers.h"

#ifdef __WXMSW__
#include <wx/msw/winundef.h>
#endif // __WXMSW__

#include "cpp/compat.h"
#include "cpp/typedef.h"

#include "cpp/v_cback.h"

#include "cpp/window.h"
#include "cpp/validators.h"
#include "cpp/sizer.h"
#include "cpp/scrolledwindow.h"
#include "cpp/splitterwindow.h"

#include "cpp/validators.cpp"

MODULE=Wx_Win PACKAGE=Wx::Window

#FIXME// unimplemented
# bool LoadFromResource( wxWindow* parent, wxString name, wxResourceTable* )
# void SetAcceleratortable( wxAcceleratorTable* )
# void SetDroptarget( wxDroptarget )
# // internal // void RemoveChild( wxWindow* child )
# // obsolete // void SetPalette( wxPalette )
# // internal // virtual void AddChild( wxWindow* window )
# // internal // virtual void DestroyChildren()

Wx_Window*
Wx_Window::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0 , name = wxPanelNameStr)
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new _wxWindow( CLASS, parent, id, pos, size, style, name );
  OUTPUT:
    RETVAL

void
Wx_Window::CaptureMouse()

void
Wx_Window::Centre( direction = wxBOTH )
    int direction

void
Wx_Window::CentreOnParent( direction = wxBOTH )
    int direction

void
Wx_Window::CentreOnScreen( direction = wxBOTH )
    int direction

void
Wx_Window::Clear()

Wx_Point*
Wx_Window::ClientToScreenPoint( point )
    Wx_Point point
  CODE:
    RETVAL = new wxPoint( THIS->ClientToScreen( point ) );
  OUTPUT:
    RETVAL

void
Wx_Window::ClientToScreenXY( x, y )
    int x
    int y
  PPCODE:
    THIS->ClientToScreen( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

bool
Wx_Window::Close( force = FALSE )
    bool force

Wx_Point*
Wx_Window::ConvertDialogPointToPixels( point )
    Wx_Point point
  CODE:
    RETVAL = new wxPoint( THIS->ConvertDialogToPixels( point ) );
  OUTPUT:
    RETVAL

Wx_Size*
Wx_Window::ConvertDialogSizeToPixels( size )
    Wx_Size size
  CODE:
    RETVAL = new wxSize( THIS->ConvertDialogToPixels( size ) );
  OUTPUT:
    RETVAL

Wx_Point*
Wx_Window::ConvertPixelsPointToDialog( point )
    Wx_Point point
  CODE:
    RETVAL = new wxPoint( THIS->ConvertPixelsToDialog( point ) );
  OUTPUT:
    RETVAL

Wx_Size*
Wx_Window::ConvertPixelsSizeToDialog( size )
    Wx_Size size
  CODE:
    RETVAL = new wxSize( THIS->ConvertPixelsToDialog( size ) );
  OUTPUT:
    RETVAL

bool
Wx_Window::Destroy()

#if __WXMSW__

void
Wx_Window::DragAcceptFiles( accept )
    bool accept

#endif // __WXMSW__

void
Wx_Window::Enable( enable )
    bool enable

Wx_Window*
FindFocus()
  CODE:
    RETVAL = wxWindow::FindFocus();
  OUTPUT:
    RETVAL

Wx_Window*
Wx_Window::FindWindow( i )
    SV* i
  PREINIT:
    const char* name;
    int id;
  CODE:
    if( looks_like_number( i ) ) {
      id = SvIV( i );
      RETVAL = THIS->FindWindow( id );
    }
    else {
      name = SvPV_nolen( i );
      RETVAL = THIS->FindWindow( name );
    }
  OUTPUT:
    RETVAL

void
Wx_Window::Fit()

Wx_Colour*
Wx_Window::GetBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetBackgroundColour() );
  OUTPUT:
    RETVAL

Wx_Size*
Wx_Window::GetBestSize()
  CODE:
    RETVAL = new wxSize( THIS->GetBestSize() );
  OUTPUT:
    RETVAL

Wx_Caret*
Wx_Window::GetCaret()

int
Wx_Window::GetCharHeight()

int
Wx_Window::GetCharWidth()

void
Wx_Window::GetChildren()
  PPCODE:
    const wxWindowList& list = THIS->GetChildren();
    wxWindowListNode* node;
    
    EXTEND( SP, list.GetCount() );

    for( node = list.GetFirst(); node; node = node->GetNext() )
      PUSHs( _object_2_sv( sv_newmortal(), node->GetData() ) );

Wx_Size*
Wx_Window::GetClientSize()
  CODE:
    RETVAL = new wxSize( THIS->GetClientSize() );
  OUTPUT:
    RETVAL

void
Wx_Window::GetClientSizeXY()
  PREINIT:
    int x;
    int y;
  PPCODE:
    THIS->GetClientSize( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

# Wx_DropTarget*
# Wx_Window::GetDropTarget()

Wx_EvtHandler*
Wx_Window::GetEventHandler()

long
Wx_Window::GetExtraStyle()

Wx_Font*
Wx_Window::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );
  OUTPUT:
    RETVAL

Wx_Colour*
Wx_Window::GetForegroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetForegroundColour() );
  OUTPUT:
    RETVAL

Wx_Window*
Wx_Window::GetGrandParent()

#if __WXMSW__

long
Wx_Window::GetHandle()

#endif // __WXMSW__

#if WXPERL_W_VERSION_GE( 2, 3 )

wxString
Wx_Window::GetHelpText()

#endif

int
Wx_Window::GetId()

wxString
Wx_Window::GetLabel()

Wx_LayoutConstraints*
Wx_Window::GetConstraints()

wxString
Wx_Window::GetName()

Wx_Window*
Wx_Window::GetParent()

Wx_Point*
Wx_Window::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

void
Wx_Window::GetPositionXY()
  PREINIT:
    int x;
    int y;
  PPCODE:
    THIS->GetPosition( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( (IV) x ) ) );
    PUSHs( sv_2mortal( newSViv( (IV) y ) ) );

Wx_Rect*
Wx_Window::GetRect()
  CODE:
    RETVAL = new wxRect( THIS->GetRect() );
  OUTPUT:
    RETVAL

int
Wx_Window::GetScrollThumb( orientation )
    int orientation

int
Wx_Window::GetScrollPos( orientation )
    int orientation

int
Wx_Window::GetScrollRange( orientation )
    int orientation

Wx_Size*
Wx_Window::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

void
Wx_Window::GetSizeWH()
  PREINIT:
    int x;
    int y;
  CODE:
    THIS->GetSize( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( (IV) x ) ) );
    PUSHs( sv_2mortal( newSViv( (IV) y ) ) );

void
Wx_Window::GetTextExtent( string, font = 0 )
    wxString string
    Wx_Font* font
  PREINIT:
    int x;
    int y;
    int descent;
    int externalLeading;
  CODE:
    THIS->GetTextExtent( string, &x, &y, &descent, &externalLeading,
        font );
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );
    PUSHs( sv_2mortal( newSViv( descent ) ) );
    PUSHs( sv_2mortal( newSViv( externalLeading ) ) );

wxString
Wx_Window::GetTitle()

#if !defined( __WXMOTIF__ ) || defined( __WXPERL_FORCE__ )

Wx_ToolTip*
Wx_Window::GetToolTip()

#endif

Wx_Region*
Wx_Window::GetUpdateRegion()
  CODE:
    RETVAL = new wxRegion( THIS->GetUpdateRegion() );
  OUTPUT:
    RETVAL

Wx_Validator*
Wx_Window::GetValidator()

long
Wx_Window::GetWindowStyleFlag()

void
Wx_Window::InitDialog()

bool
Wx_Window::IsEnabled()

bool
Wx_Window::IsExposedXYWH( x, y, w = 0, h = 0 )
    int x
    int y
    int w
    int h
  CODE:
    RETVAL = THIS->IsExposed( x, y, w, h );
  OUTPUT:
    RETVAL

bool
Wx_Window::IsExposedPoint( point )
    Wx_Point point
  CODE:
    RETVAL = THIS->IsExposed( point );
  OUTPUT:
    RETVAL

bool
Wx_Window::IsExposedRect( rect )
    Wx_Rect* rect
  CODE:
    RETVAL = THIS->IsExposed( *rect );
  OUTPUT:
    RETVAL
    
bool
Wx_Window::IsRetained()

bool
Wx_Window::IsShown()

bool
Wx_Window::IsTopLevel()

void
Wx_Window::Layout()

void
Wx_Window::Lower()

void
Wx_Window::MakeModal( flag )
    bool flag

void
Wx_Window::MoveXY( x, y )
    int x
    int y
  CODE:
    THIS->Move( x, y );

void
Wx_Window::MovePoint( point )
    Wx_Point point
  CODE:
    THIS->Move( point );

Wx_EvtHandler*
Wx_Window::PopEventHandler( deleteHandler )
    bool deleteHandler

bool
Wx_Window::PopupMenuPoint( menu, point )
    Wx_Menu* menu
    Wx_Point point
  CODE:
    RETVAL = THIS->PopupMenu( menu, point );
  OUTPUT:
    RETVAL

bool
Wx_Window::PopupMenuXY( menu, x, y )
    Wx_Menu* menu
    int x
    int y
  CODE:
    RETVAL = THIS->PopupMenu( menu, x, y );
  OUTPUT:
    RETVAL

void
Wx_Window::PushEventHandler( handler )
    Wx_EvtHandler* handler

void
Wx_Window::Raise()

void
Wx_Window::Refresh( eraseBackground = TRUE, rect = 0 )
    bool eraseBackground
    Wx_Rect* rect

void
Wx_Window::ReleaseMouse()

bool
Wx_Window::Reparent( newParent )
    Wx_Window* newParent

Wx_Point*
Wx_Window::ScreenToClientPoint( point )
    Wx_Point point
  CODE:
    RETVAL = new wxPoint( THIS->ScreenToClient( point ) );
  OUTPUT:
    RETVAL

void
Wx_Window::ScreenToClientXY( x, y )
    int x
    int y
  PPCODE:
    THIS->ScreenToClient( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( (IV) x ) ) );
    PUSHs( sv_2mortal( newSViv( (IV) y ) ) );

void
Wx_Window::ScrollWindow( x, y, rect = 0 )
    int x
    int y
    Wx_Rect* rect

void
Wx_Window::SetAutoLayout( autoLayout )
    bool autoLayout

void
Wx_Window::SetBackgroundColour( colour )
    Wx_Colour* colour
  CODE:
    THIS->SetBackgroundColour( *colour );

void
Wx_Window::SetCaret( caret )
    Wx_Caret* caret

void
Wx_Window::SetClientSizeSize( size )
    Wx_Size size
  CODE:
    THIS->SetClientSize( size );

void
Wx_Window::SetClientSizeWH( width, height )
    int width
    int height
  CODE:
    THIS->SetClientSize( width, height );

void
Wx_Window::SetConstraints( constraints )
    Wx_LayoutConstraints* constraints

void
Wx_Window::SetCursor( cursor )
    Wx_Cursor* cursor
  CODE:
    THIS->SetCursor( *cursor );

void
Wx_Window::SetEventHandler( handler )
    Wx_EvtHandler* handler

void
Wx_Window::SetExtraStyle( style )
    long style

void
Wx_Window::SetFocus()

void
Wx_Window::SetForegroundColour( colour )
    Wx_Colour* colour
  CODE:
    THIS->SetForegroundColour( *colour );

#if WXPERL_W_VERSION_GE( 2, 3 )

void
Wx_Window::SetHelpText( text )
    wxString text

void
Wx_Window::SetHelpTextForId( text )
    wxString text

#endif

void
Wx_Window::SetId( id )
    int id

void
Wx_Window::SetLabel( label )
    wxString label

void
Wx_Window::SetName( name )
    wxString name

void
Wx_Window::SetScrollbar( orientation, position, thumbSize, range, refresh = TRUE )
    int orientation
    int position
    int thumbSize
    int range
    bool refresh

void
Wx_Window::SetScrollPos( orientation, position, refresh = TRUE )
    int orientation
    int position
    bool refresh

void
Wx_Window::SetFont( font )
    Wx_Font* font
  CODE:
    THIS->SetFont( *font );

void
Wx_Window::SetSizeSize( size )
    Wx_Size size
  CODE:
    THIS->SetSize( size );

void
Wx_Window::SetSizeRect( rect )
    Wx_Rect* rect
  CODE:
    THIS->SetSize( *rect );

void
Wx_Window::SetSizeWH( width, height )
    int width
    int height
  CODE:
    THIS->SetSize( width, height );

void
Wx_Window::SetSizeXYWHF( x, y, width, height, flags = wxSIZE_AUTO )
    int x
    int y
    int width
    int height
    int flags
  CODE:
    THIS->SetSize( x, y, width, height, flags );

void
Wx_Window::SetSizeHints( minW = -1, minH = -1, maxW = -1, maxH = -1, incW = -1, incH = -1 )
    int minW
    int minH
    int maxW
    int maxH
    int incW
    int incH

void
Wx_Window::SetSizer( sizer )
    Wx_Sizer* sizer

void
Wx_Window::SetTitle( title )
    wxString title

#if !defined( __WXMOTIF__ ) || defined( __WXPERL_FORCE__ )

void
Wx_Window::SetToolTipTip( tooltip )
    Wx_ToolTip* tooltip
  CODE:
    THIS->SetToolTip( tooltip );

void
Wx_Window::SetToolTipString( string )
    wxString string
  CODE:
    THIS->SetToolTip( string );

#endif

void
Wx_Window::SetValidator( validator )
    Wx_Validator* validator
  CODE:
    THIS->SetValidator( *validator );

void
Wx_Window::SetWindowStyle( style )
    long style

void
Wx_Window::SetWindowStyleFlag( style )
    long style

bool
Wx_Window::Show( show )
    bool show

bool
Wx_Window::TransferDataFromWindow()
  CODE:
    RETVAL = THIS->wxWindow::TransferDataFromWindow();
  OUTPUT:
    RETVAL

bool
Wx_Window::TransferDataToWindow()
  CODE:
    RETVAL = THIS->wxWindow::TransferDataToWindow();
  OUTPUT:
    RETVAL

bool
Wx_Window::Validate()
  CODE:
    RETVAL = THIS->wxWindow::Validate();
  OUTPUT:
    RETVAL

void
Wx_Window::WarpPointer( x, y )
    int x
    int y

INCLUDE: XS/SplitterWindow.xs
INCLUDE: XS/ScrolledWindow.xs
INCLUDE: XS/Validators.xs
INCLUDE: XS/Constraint.xs
INCLUDE: XS/Sizer.xs

MODULE=Wx_Win PACKAGE=Wx::Window

