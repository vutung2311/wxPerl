/////////////////////////////////////////////////////////////////////////////
// Name:        Controls.xs
// Purpose:     XS for Wx::Control and derived classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: Controls.xs,v 1.32 2004/02/28 22:58:57 mbarbon Exp $
// Copyright:   (c) 2000-2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#include <wx/defs.h>

#include <wx/imaglist.h>
#include <wx/event.h>
#include <wx/colour.h>
#include <wx/listctrl.h>
#include <wx/treectrl.h>
#include <wx/ctrlsub.h>

// needs to be here to see #defines
#include "cpp/typedef.h"

// re-include for client data
#include "cpp/helpers.h"

#undef THIS

#include "cpp/v_cback.h"

#include "cpp/controls.h"
#include "cpp/controls.cpp"
#include "cpp/overload.h"

WXPLI_BOOT_ONCE(Wx_Ctrl);
#define boot_Wx_Ctrl wxPli_boot_Wx_Ctrl

MODULE=Wx_Ctrl PACKAGE=Wx::Control

void
wxControl::Command( event )
    wxCommandEvent* event
  CODE:
    THIS->Command( *event );

MODULE=Wx_Ctrl PACKAGE=Wx::ControlWithItems

void
wxControlWithItems::Append( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_s_s, AppendData )
        MATCH_REDISP( wxPliOvl_s, AppendString )
    END_OVERLOAD( Wx::ControlWithItems::Append )

void
wxControlWithItems::AppendString( item )
    wxString item
  CODE:
    THIS->Append( item );

void
wxControlWithItems::AppendData( item, data )
    wxString item
    wxPliUserDataCD* data
  CODE:
    THIS->Append( item, data );

void
wxControlWithItems::Delete( n )
    int n

int
wxControlWithItems::FindString( string )
    wxString string

int
wxControlWithItems::GetCount()

int
wxControlWithItems::GetSelection()

wxString
wxControlWithItems::GetString( n )
    int n

wxString
wxControlWithItems::GetStringSelection()

wxPliUserDataCD*
wxControlWithItems::GetClientData( n )
    int n
  CODE:
    RETVAL = (wxPliUserDataCD*) THIS->GetClientObject( n );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

bool
wxControlWithItems::IsEmpty()

#endif

void
wxControlWithItems::SetClientData( n, data )
    int n
    wxPliUserDataCD* data
  CODE:
    THIS->SetClientObject( n, data );

INCLUDE: XS/BitmapButton.xs

INCLUDE: perl script/xsubppp.pl --typemap typemap.xsp XS/BookCtrl.xsp |

INCLUDE: perl script/xsubppp.pl --typemap typemap.xsp XS/Listbook.xsp |

INCLUDE: XS/Button.xs
INCLUDE: XS/CheckBox.xs
INCLUDE: XS/CheckListBox.xs
INCLUDE: XS/Choice.xs
INCLUDE: XS/ComboBox.xs
INCLUDE: XS/Gauge.xs
INCLUDE: XS/ListBox.xs
INCLUDE: XS/ListCtrl.xs
INCLUDE: XS/Notebook.xs
INCLUDE: XS/RadioBox.xs
INCLUDE: XS/RadioButton.xs
INCLUDE: XS/ScrollBar.xs
INCLUDE: XS/Slider.xs
INCLUDE: XS/SpinButton.xs
INCLUDE: XS/SpinCtrl.xs
INCLUDE: XS/StaticBitmap.xs
INCLUDE: XS/StaticBox.xs
INCLUDE: XS/StaticLine.xs
INCLUDE: XS/StaticText.xs
INCLUDE: XS/ToggleButton.xs
INCLUDE: XS/TextCtrl.xs
INCLUDE: XS/TreeCtrl.xs

MODULE=Wx_Ctrl PACKAGE=Wx::Control
