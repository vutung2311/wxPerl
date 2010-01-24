/////////////////////////////////////////////////////////////////////////////
// Name:        Threading.xs
// Purpose:     minimal XS support functions for threading
// Author:      Mattia Barbon
// Modified by:
// Created:     24/01/2010
// RCS-ID:      $Id$
// Copyright:   (c) 2006-2008, 2010 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/threadevent.h"

#include <wx/event.h>
#include <wx/window.h>
#include <wx/app.h>

WXPLI_BOOT_ONCE(Wx_Threading);
#define boot_Wx_Threading wxPli_boot_Wx_Threading

MODULE=Wx_Threading PACKAGE=Wx::Event

# unimplemented ( and probably will never be: problems with object
#                 cloning/destruction )
# GetObjectType

static void
wxEvent::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxEvent::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ wxPli_get_class( aTHX_ ST(0) ), THIS, ST(0) );
    delete THIS;

# void
# wxEvent::Destroy()
#   CODE:
#     delete THIS;

void
wxEvent::GetEventObject()
  PPCODE:
    // to avoid problems with deletion, only windows are supported
    wxObject* obj = THIS->GetEventObject();
    wxWindow* win = wxDynamicCast( obj, wxWindow );

    EXTEND( SP, 1 );
    if(win == NULL)
        PUSHs( &PL_sv_undef );
    else
        PUSHs( wxPli_object_2_sv( aTHX_ NEWSV( 0, 0 ), win ) );
        
wxEventType
wxEvent::GetEventType()

int
wxEvent::GetId()

bool
wxEvent::GetSkipped()

long
wxEvent::GetTimestamp()

void
wxEvent::SetEventType( type )
    wxEventType type

## will likely need to be restricted to wxWindow (for ownership problems)
void
wxEvent::SetEventObject( object )
    wxObject* object

void
wxEvent::SetId( id )
    wxWindowID id

void
wxEvent::SetTimestamp( timeStamp )
    long timeStamp

void
wxEvent::Skip( skip = true )
    bool skip

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

bool
wxEvent::ShouldPropagate()

#endif

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

int
wxEvent::StopPropagation()

void
wxEvent::ResumePropagation( propagationLevel )
    int propagationLevel

#else
#if WXPERL_W_VERSION_GE( 2, 5, 1 )

void
wxEvent::SetPropagate( doIt )
    bool doIt

#endif
#endif

MODULE=Wx_Threading PACKAGE=Wx::PlThreadEvent

wxPlThreadEvent*
wxPlThreadEvent::new( type, id, data )
    wxEventType type
    wxWindowID id
    SV* data
  CODE:
    RETVAL = new wxPlThreadEvent( aTHX_ CLASS, type, id, data );
  OUTPUT: RETVAL

int
wxPlThreadEvent::_GetData()
  CODE:
    RETVAL = THIS ? THIS->_GetData() : 0;
  OUTPUT: RETVAL

SV*
wxPlThreadEvent::GetData()
  CODE:
    RETVAL = THIS ? THIS->GetData() : &PL_sv_undef;
  OUTPUT: RETVAL

void
SetStash( hv_ref )
    SV* hv_ref
  CODE:
    wxPlThreadEvent::SetStash( hv_ref );

MODULE=Wx_Threading PACKAGE=Wx PREFIX=wx

void
wxPostEvent( evthnd, event )
    wxEvtHandler* evthnd
    wxEvent* event
  CODE:
    wxPostEvent( evthnd, *event );

wxEventType
wxNewEventType()

MODULE=Wx_Threading PACKAGE=Wx

SV*
wxThreadApp()
  CODE:
    RETVAL = sv_setref_pv( newSV(0), "Wx::_App", wxTheApp );
  OUTPUT: RETVAL
