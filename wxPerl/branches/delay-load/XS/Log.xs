/////////////////////////////////////////////////////////////////////////////
// Name:        XS/Log.xs
// Purpose:     XS for Wx::Log and derived classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id$
// Copyright:   (c) 2000-2003, 2005-2007, 2009 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT
#include "cpp/wxapi.h"
#include "cpp/log.h"
#include <wx/log.h>
#include <wx/frame.h>

MODULE=Wx_Log PACKAGE=Wx::Log

void
wxLog::Destroy()
  CODE:
    delete THIS;

void
AddTraceMask( mask )
    wxString mask
  CODE:
    wxLog::AddTraceMask( mask );

void
ClearTraceMasks()
  CODE:
    wxLog::ClearTraceMasks();

void
RemoveTraceMask( mask )
    wxString mask
  CODE:
    wxLog::RemoveTraceMask( mask );

bool
IsAllowedTraceMask( mask )
    wxString mask
  CODE:
    RETVAL = wxLog::IsAllowedTraceMask( mask );
  OUTPUT:
    RETVAL

wxLog*
GetActiveTarget()
  CODE:
    RETVAL = wxLog::GetActiveTarget();
  OUTPUT:
    RETVAL

wxLog*
SetActiveTarget( target )
    wxLog* target
  CODE:
    RETVAL = wxLog::SetActiveTarget( target );
  OUTPUT:
    RETVAL

void
DontCreateOnDemand()
  CODE:
    wxLog::DontCreateOnDemand();

void
wxLog::Flush()

void
wxLog::FlushActive()

bool
wxLog::HasPendingMessages()

void
wxLog::SetVerbose( verbose = true )
    bool verbose

bool
wxLog::GetVerbose()

#if WXPERL_W_VERSION_GE( 2, 9, 0 )

void
_SetTimestamp( format, buffer )
    wxString format
    SV* buffer
  CODE:
    wxLog::SetTimestamp( format );

wxString
wxLog::GetTimestamp();

#else

void
_SetTimestamp( format, buffer )
    SV* format
    SV* buffer
  CODE:
    if( SvOK( ST(0) ) ) {
        const wxString format_tmp = ( SvUTF8( format ) ) ?
                  ( wxString( SvPVutf8_nolen( format ), wxConvUTF8 ) )
                : ( wxString( SvPV_nolen( format ), wxConvLibc ) );
        const wxChar* fmt = (const wxChar*)format_tmp.c_str();
        STRLEN size = wxStrlen( fmt ) * sizeof(wxChar) + sizeof(wxChar);
        SvUPGRADE( buffer, SVt_PV );
        wxLog::SetTimestamp( wxStrcpy( (wxChar*)SvGROW( buffer, size ),
                             fmt ) );
    } else {
        wxLog::SetTimestamp( NULL );
    }

const wxChar*
wxLog::GetTimestamp()

#endif

void
SetTraceMask( mask )
    wxTraceMask mask
  CODE:
    wxLog::SetTraceMask( mask );

wxTraceMask
GetTraceMask()
  CODE:
    RETVAL = wxLog::GetTraceMask();
  OUTPUT:
    RETVAL

MODULE=Wx_Log PACKAGE=Wx::PlLog

wxPlLog*
wxPlLog::new()
  CODE:
    RETVAL = new wxPlLog( CLASS );
  OUTPUT:
    RETVAL

MODULE=Wx_Log PACKAGE=Wx::LogTextCtrl

wxLogTextCtrl*
wxLogTextCtrl::new( ctrl )
    wxTextCtrl* ctrl

MODULE=Wx_Log PACKAGE=Wx::LogNull

wxLogNull*
wxLogNull::new()

static void
wxLogNull::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxLogNull::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::LogNull", THIS, ST(0) );
    delete THIS;

MODULE=Wx_Log PACKAGE=Wx::LogGui

wxLogGui*
wxLogGui::new()

MODULE=Wx_Log PACKAGE=Wx::LogWindow

wxLogWindow*
wxLogWindow::new( parent, title, show = true, passtoold = true )
    wxFrame* parent
    wxString title
    bool show
    bool passtoold

MODULE=Wx_Log PACKAGE=Wx::LogChain

wxLogChain*
wxLogChain::new( logger )
    wxLog* logger

wxLog*
wxLogChain::GetOldLog()

bool
wxLogChain::IsPassingMessages()

void
wxLogChain::PassMessages( passMessages )
    bool passMessages

void
wxLogChain::SetLog( logger )
    wxLog* logger

MODULE=Wx_Log PACKAGE=Wx::LogPassThrough

wxLogPassThrough*
wxLogPassThrough::new()

MODULE=Wx_Log PACKAGE=Wx::PlLogPassThrough

wxPlLogPassThrough*
wxPlLogPassThrough::new()
  CODE:
    RETVAL = new wxPlLogPassThrough( CLASS );
  OUTPUT:
    RETVAL

MODULE=Wx_Log PACKAGE=Wx::LogStderr

wxLogStderr*
wxLogStderr::new( fp = NULL )
    FILE* fp;
