#############################################################################
## Name:        Frame.xs
## Purpose:     XS for Wx::Frame
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/frame.h>
#include <wx/menu.h>
#if wxPERL_USE_MINIFRAME
#include <wx/minifram.h>
#endif
#include "cpp/frame.h"

MODULE=Wx PACKAGE=Wx::Frame

Wx_Frame*
Wx_Frame::new( parent, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxFrameNameStr )
 # this is not completely correct, but should be harmless
    Wx_Window* parent
    wxWindowID id
    wxString title
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliFrame( CLASS , parent, id, title, pos, size, style, name );
  OUTPUT:
    RETVAL

void
Wx_Frame::Command( id )
    int id

Wx_StatusBar*
Wx_Frame::CreateStatusBar( number = 1, style = 0, id = -1, name = wxEmptyString )
    int number
    long style
    wxWindowID id
    wxString name

Wx_ToolBar*
Wx_Frame::CreateToolBar( style = wxNO_BORDER | wxTB_HORIZONTAL, id = -1, name = wxToolBarNameStr )
    long style
    wxWindowID id
    wxString name

Wx_Point*
Wx_Frame::GetClientAreaOrigin()
  CODE:
    RETVAL = new wxPoint( THIS->GetClientAreaOrigin() );
  OUTPUT:
    RETVAL

Wx_MenuBar*
Wx_Frame::GetMenuBar()

Wx_StatusBar*
Wx_Frame::GetStatusBar()

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

int
Wx_Frame::GetStatusBarPane()

#endif

Wx_ToolBar*
Wx_Frame::GetToolBar()

void
Wx_Frame::Iconize( iconize )
    bool iconize

bool
Wx_Frame::IsIconized()

bool
Wx_Frame::IsMaximized()

#if defined( __WXMSW__ ) || \
 ( defined( __WXGTK__ ) && WXPERL_W_VERSION_GE( 2, 3, 1 ) ) \
 || defined( __WXPERL_FORCE__ )

bool
Wx_Frame::IsFullScreen()

#endif

void
Wx_Frame::Maximize( maximize )
    bool maximize

wxStatusBar*
wxFrame::OnCreateStatusBar( number, style, id, name )
    int number
    long style
    wxWindowID id
    wxString name
  CODE:
    RETVAL = THIS->wxFrame::OnCreateStatusBar( number, style, id, name );
  OUTPUT: RETVAL

void
Wx_Frame::SetIcon( icon )
    Wx_Icon* icon
  CODE:
    THIS->SetIcon( *icon );

#if WXPERL_W_VERSION_GE( 2, 4, 0 )

void
wxFrame::SetIcons( icons )
    wxIconBundle* icons
  C_ARGS: *icons

#endif

void
Wx_Frame::SetMenuBar( menubar )
    Wx_MenuBar* menubar

void
Wx_Frame::SetStatusBar( statusBar )
    Wx_StatusBar* statusBar

void
Wx_Frame::SetToolBar( toolbar )
    Wx_ToolBar* toolbar

void
Wx_Frame::SetStatusText( text, number = 0 )
    wxString text
    int number

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

void
Wx_Frame::SetStatusBarPane( n )
    int n

#endif

void
Wx_Frame::SetStatusWidths( ... )
  PREINIT:
    int* w;
    int i;
  CODE:
    w = new int[items - 1];
    for( i = 0; i < items - 1; ++i )
    {
      w[i] = SvIV( ST( i + 1 ) );
    }
    THIS->SetStatusWidths( items - 1, w );
    delete [] w;

#if defined( __WXMSW__ ) || \
 ( defined( __WXGTK__ ) && WXPERL_W_VERSION_GE( 2, 3, 1 ) ) \
 || defined( __WXPERL_FORCE__ )

bool
Wx_Frame::ShowFullScreen( show, style = wxFULLSCREEN_ALL )
    bool show
    long style

#endif

MODULE=Wx PACKAGE=Wx::MiniFrame

#if wxPERL_USE_MINIFRAME

Wx_MiniFrame*
Wx_MiniFrame::new( parent, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxFrameNameStr )
    Wx_Window* parent
    wxWindowID id
    wxString title
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliMiniFrame( CLASS, parent, id, title, pos, size, 
        style, name );
  OUTPUT:
    RETVAL

#endif