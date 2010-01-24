/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/threadevent.h
// Purpose:     C++ helper for Wx::PlThreadEvent
// Author:      Mattia Barbon
// Modified by:
// Created:     24/01/2010
// RCS-ID:      $Id$
// Copyright:   (c) 2006-2007, 2010 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <wx/event.h>

class wxPlThreadEvent : public wxEvent
{
    WXPLI_DECLARE_DYNAMIC_CLASS_CTOR( wxPlThreadEvent );
public:
    static void SetStash( SV* hv_ref )
    {
        m_hv = (HV*)SvRV( hv_ref );
    }
    static HV* GetStash() { return m_hv; }

    wxPlThreadEvent() : m_data( 0 ) {}
    wxPlThreadEvent( pTHX_ const char* package, int id, wxEventType eventType,
                     SV* data )
        : wxEvent( id, eventType )
    {
        PL_lockhook( aTHX_ (SV*)GetStash() );
        PL_sharehook( aTHX_ data );
        int data_id;
        char buffer[30];
        size_t length;
        for(;;)
        {
            data_id = rand();
            length = sprintf( buffer, "%d", data_id );
            if( !hv_exists( GetStash(), buffer, length ) )
                break;
        }
        SV** dst = hv_fetch( GetStash(), buffer, length, 1 );
        sv_setsv( *dst, data );
        mg_set( *dst );
        m_data = data_id;    
    }

    wxPlThreadEvent( const wxPlThreadEvent& e )
        : wxEvent( e ),
          m_data( e.m_data )
    { }

    ~wxPlThreadEvent()
    { 
        if( !m_data )
            return;

        dTHX;

        ENTER;
        SAVETMPS;

        PL_lockhook( aTHX_ (SV*)m_hv );

        char buffer[30];
        size_t length = sprintf( buffer, "%d", m_data );

        hv_delete( m_hv, buffer, length, G_DISCARD );

        FREETMPS;
        LEAVE;
    }

    int _GetData() const { return m_data; }

    SV* GetData() const
    {
        dTHX;

        if( !m_data )
            return &PL_sv_undef;

        PL_lockhook( aTHX_ (SV*)m_hv );

        char buffer[30];
        size_t length = sprintf( buffer, "%d", m_data );

        SV** value = hv_fetch( m_hv, buffer, length, 0 );
        if( !value )
            return NULL;
        mg_get( *value );
        SvREFCNT_inc( *value );

        return *value;
    }

    virtual wxEvent* Clone() const;
private:
    int m_data;
    static HV* m_hv;
};

wxEvent* wxPlThreadEvent::Clone() const
{
    wxEvent* clone = new wxPlThreadEvent( *this );
    ((wxPlThreadEvent*)this)->m_data = 0;

    return clone;
}

HV* wxPlThreadEvent::m_hv = NULL;

wxPliSelfRef* wxPliGetSelfForwxPlThreadEvent( wxObject* object ) { return 0; }
// XXX HACK!
#if wxUSE_EXTENDED_RTTI
const wxClassInfo* wxPlThreadEvent::ms_classParents[] =
    { &wxEvent::ms_classInfo , NULL };
wxPliClassInfo wxPlThreadEvent::ms_classInfo(
    ms_classParents, (wxChar*)wxT( "wxPlPlThreadEvent"),
    (int)sizeof(wxPlThreadEvent), wxPlThreadEvent::wxCreateObject,
    (wxPliGetCallbackObjectFn) wxPliGetSelfForwxPlThreadEvent );
#else
wxPliClassInfo wxPlThreadEvent::ms_classInfo(
    (wxChar*)wxT( "wxPlPlThreadEvent"), &wxEvent::ms_classInfo,
    NULL, (int)sizeof(wxPlThreadEvent), wxPlThreadEvent::wxCreateObject,
    (wxPliGetCallbackObjectFn) wxPliGetSelfForwxPlThreadEvent );
#endif
wxObject* wxPlThreadEvent::wxCreateObject() { return new wxPlThreadEvent(); }

// local variables: //
// mode: c++ //
// end: //
