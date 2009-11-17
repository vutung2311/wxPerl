/////////////////////////////////////////////////////////////////////////////
// Name:        XS/Button.xs
// Purpose:     XS for Wx::Button
// Author:      Mattia Barbon
// Modified by:
// Created:     08/11/2000
// RCS-ID:      $Id$
// Copyright:   (c) 2000-2001, 2003, 2009 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT
#include "cpp/wxapi.h"
#include "cpp/overload.h"
#include <wx/button.h>

MODULE=Wx_Button PACKAGE=Wx::Button

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::Button::new" )

wxButton*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxButton();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxButton*
newFull( CLASS, parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxButtonNameStr )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxString label
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxButton( parent, id, label, pos, size, 
        style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxButton::Create( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxButtonNameStr )
    wxWindow* parent
    wxWindowID id
    wxString label
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  C_ARGS: parent, id, label, pos, size, style, *validator, name

wxSize*
GetDefaultSize()
  CODE:
    RETVAL = new wxSize( wxButton::GetDefaultSize() );
  OUTPUT:
    RETVAL

void
wxButton::SetDefault()
