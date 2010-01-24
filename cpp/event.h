/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/event.h
// Purpose:     C++ helpers for user-defined events
// Author:      Mattia Barbon
// Modified by:
// Created:     30/03/2002
// RCS-ID:      $Id$
// Copyright:   (c) 2002-2004, 2006-2007, 2009-2010 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <wx/event.h>

#include "cpp/v_cback.h"

class wxPlEvent : public wxEvent
{
    WXPLI_DECLARE_DYNAMIC_CLASS_CTOR( wxPlEvent );
    WXPLI_DECLARE_V_CBACK();

    // only to appease wxWidgets' RTTI
    wxPlEvent() : m_callback( NULL ) {}
public:
    wxPlEvent( const char* package, int id, wxEventType eventType )
        : wxEvent( id, eventType ),
          m_callback( "Wx::PlEvent" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }

    virtual ~wxPlEvent()
    {
        m_callback.DeleteSelf( false );
    }

    virtual wxEvent* Clone() const;
};

wxEvent* wxPlEvent::Clone() const
{
    dTHX;
    wxPlEvent* self = (wxPlEvent*)this;

    // only to appease wxWidgets' RTTI
    if( !self->m_callback.IsOk() )
        return new wxPlEvent();

    if( wxPliVirtualCallback_FindCallback( aTHX_ &self->m_callback, "Clone" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback
            ( aTHX_ &self->m_callback, G_SCALAR, NULL );
        wxPlEvent* clone =
            (wxPlEvent*)wxPli_sv_2_object( aTHX_ ret, "Wx::PlEvent" );
        
        return clone;
    }

    return 0;
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS_CTOR( wxPlEvent, wxEvent );

class wxPlCommandEvent : public wxCommandEvent
{
    WXPLI_DECLARE_DYNAMIC_CLASS_CTOR( wxPlCommandEvent );
    WXPLI_DECLARE_V_CBACK();

    // only to appease wxWidgets' RTTI
    wxPlCommandEvent() : m_callback( NULL ) {}
public:
    wxPlCommandEvent( const char* package, int id, wxEventType eventType )
        : wxCommandEvent( id, eventType ),
          m_callback( "Wx::PlCommandEvent" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }

    virtual ~wxPlCommandEvent()
    {
        m_callback.DeleteSelf( false );
    }

    virtual wxEvent* Clone() const;
};

wxEvent* wxPlCommandEvent::Clone() const
{
    dTHX;
    wxPlCommandEvent* self = (wxPlCommandEvent*)this;

    // only to appease wxWidgets' RTTI
    if( !self->m_callback.IsOk() )
        return new wxPlCommandEvent();

    if( wxPliVirtualCallback_FindCallback( aTHX_ &self->m_callback, "Clone" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback
            ( aTHX_ &self->m_callback, G_SCALAR, NULL );
        wxPlCommandEvent* clone = (wxPlCommandEvent*)
            wxPli_sv_2_object( aTHX_ ret, "Wx::PlCommandEvent" );

        return clone;
    }

    return 0;
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS_CTOR( wxPlCommandEvent, wxCommandEvent );

// local variables: //
// mode: c++ //
// end: //
