/////////////////////////////////////////////////////////////////////////////
// Name:        Controls.xs
// Purpose:     XS for Wx::Control and derived classes
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

#include <wx/button.h>
#include <wx/listbox.h>
#include <wx/radiobut.h>
#include <wx/radiobox.h>
#include <wx/choice.h>
#include <wx/combobox.h>
#include <wx/scrolbar.h>
#include <wx/statbox.h>
#include <wx/stattext.h>
#include <wx/textctrl.h>
#include <wx/checkbox.h>
#include <wx/notebook.h>
#include <wx/gauge.h>
#include <wx/checklst.h>
#include <wx/bmpbuttn.h>
#include <wx/statbmp.h>
#include <wx/slider.h>
#include <wx/spinbutt.h>
#include <wx/spinctrl.h>
#include <wx/statline.h>
#include <wx/imaglist.h>

#include <stdarg.h>

#undef _

#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#undef bool
#undef Move
#undef Copy

#if __VISUALC__
#pragma warning (disable: 4800 )
#endif

#ifdef __WXMSW__
#include <wx/msw/winundef.h>
#endif // __WXMSW__

#include "cpp/compat.h"
#include "cpp/typedef.h"
#include "cpp/helpers.h"

#include "cpp/button.h"
#include "cpp/controls.h"
#include "cpp/notebook.h"
#include "cpp/controls.cpp"

MODULE=Wx_Ctrl PACKAGE=Wx::Control

void
Wx_Control::Command( event )
    Wx_CommandEvent* event
  CODE:
    THIS->Command( *event );

MODULE=Wx_Ctrl PACKAGE=Wx::ControlWithItems

void
Wx_ControlWithItems::Append( item )
    wxString item

void
Wx_ControlWithItems::Clear()

void
Wx_ControlWithItems::Delete( n )
    int n

int
Wx_ControlWithItems::FindString( string )
    wxString string

int
Wx_ControlWithItems::GetCount()

int
Wx_ControlWithItems::GetSelection()

wxString
Wx_ControlWithItems::GetString( n )
    int n

wxString
Wx_ControlWithItems::GetStringSelection()

void
Wx_ControlWithItems::GetClientData( n )
    int n
  PREINIT:
    _wxUserDataCD* ud;
  PPCODE:
    if( ( ud = (_wxUserDataCD*)THIS->GetClientObject( n ) ) )
    {
      SvREFCNT_inc( ud->m_data );
      XPUSHs( ud->m_data );
    }
    else
    {
      XPUSHs( &PL_sv_undef );
    }

void
Wx_ControlWithItems::SetClientData( n, data )
    int n
    SV* data
  CODE:
    if( data == &PL_sv_undef )
    {
      THIS->SetClientObject( n, 0 );
    }
    else
    {
      SV* newdata = sv_newmortal();
      sv_setsv( newdata, data );
      THIS->SetClientObject( n, new _wxUserDataCD( newdata ) );
    }

INCLUDE: XS/BitmapButton.xs
INCLUDE: XS/Button.xs
INCLUDE: XS/CheckBox.xs
INCLUDE: XS/CheckListBox.xs
INCLUDE: XS/Choice.xs
INCLUDE: XS/ComboBox.xs
INCLUDE: XS/Gauge.xs
INCLUDE: XS/ListBox.xs
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
INCLUDE: XS/TextCtrl.xs

MODULE=Wx_Ctrl PACKAGE=Wx::Control
