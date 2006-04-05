#############################################################################
## Name:        XS/Utils.xs
## Purpose:     XS for some utility classes
## Author:      Mattia Barbon
## Modified by:
## Created:     09/02/2001
## RCS-ID:      $Id: Utils.xs,v 1.38 2006/02/06 18:44:38 mbarbon Exp $
## Copyright:   (c) 2001-2003, 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/busyinfo.h>
#include <wx/settings.h>
#include <wx/caret.h>
#include <wx/snglinst.h>
#include <wx/splash.h>
#include <wx/utils.h>
#include <wx/debug.h>
#include <wx/tipdlg.h>
#include "cpp/tipprovider.h"

MODULE=Wx PACKAGE=Wx::CaretSuspend

wxCaretSuspend*
wxCaretSuspend::new( window )
    wxWindow* window

void
wxCaretSuspend::DESTROY()

MODULE=Wx PACKAGE=Wx::SplashScreen

#ifndef wxFRAME_FLOAT_ON_PARENT
#define wxFRAME_FLOAT_ON_PARENT 0
#endif

#ifndef wxFRAME_TOOL_WINDOW
#define wxFRAME_TOOL_WINDOW 0
#endif

wxSplashScreen*
wxSplashScreen::new( bitmap, splashStyle, milliseconds, parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSIMPLE_BORDER|wxFRAME_NO_TASKBAR|wxSTAY_ON_TOP )
    wxBitmap* bitmap
    long splashStyle
    int milliseconds
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
  CODE:
    RETVAL = new wxSplashScreen( *bitmap, splashStyle, milliseconds, parent,
        id, pos, size, style );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::WindowDisabler

wxWindowDisabler*
wxWindowDisabler::new( skip = 0 )
    wxWindow* skip

void
wxWindowDisabler::DESTROY()

MODULE=Wx PACKAGE=Wx::BusyCursor

wxBusyCursor*
wxBusyCursor::new( cursor = wxHOURGLASS_CURSOR )
    wxCursor* cursor

void
wxBusyCursor::DESTROY()

MODULE=Wx PACKAGE=Wx::BusyInfo

wxBusyInfo*
wxBusyInfo::new( message )
    wxString message

void
wxBusyInfo::DESTROY()

MODULE=Wx PACKAGE=Wx::StopWatch

#ifdef Pause
#undef Pause
#endif

wxStopWatch*
wxStopWatch::new()

## XXX threads
void
wxStopWatch::DESTROY()

void
wxStopWatch::Pause()

void
wxStopWatch::Start( milliseconds = 0 )
    long milliseconds

void
wxStopWatch::Resume()

long
wxStopWatch::Time()

MODULE=Wx PACKAGE=Wx::SingleInstanceChecker

#if wxUSE_SNGLINST_CHECKER

wxSingleInstanceChecker*
wxSingleInstanceChecker::new()

## XXX threads
void
wxSingleInstanceChecker::DESTROY()

bool
wxSingleInstanceChecker::Create( name, path = wxEmptyString )
    wxString name
    wxString path

bool
wxSingleInstanceChecker::IsAnotherRunning()

#endif

MODULE=Wx PACKAGE=Wx::SystemSettings

#if WXPERL_W_VERSION_GE( 2, 5, 2 )
#define wxSystemSettings_GetSystemColour wxSystemSettings::GetColour
#define wxSystemSettings_GetSystemFont wxSystemSettings::GetFont
#define wxSystemSettings_GetSystemMetric wxSystemSettings::GetMetric
#else
#define wxSystemSettings_GetSystemColour wxSystemSettings::GetSystemColour
#define wxSystemSettings_GetSystemFont wxSystemSettings::GetSystemFont
#define wxSystemSettings_GetSystemMetric wxSystemSettings::GetSystemMetric
#endif

wxColour*
GetSystemColour( index )
    wxSystemColour index
  CODE:
    RETVAL = new wxColour( wxSystemSettings_GetSystemColour( index ) );
  OUTPUT: RETVAL

wxFont*
GetSystemFont( index )
    wxSystemFont index
  CODE:
    RETVAL = new wxFont( wxSystemSettings_GetSystemFont( index ) );
  OUTPUT: RETVAL

int
GetSystemMetric( index )
    wxSystemMetric index
  CODE:
    RETVAL = wxSystemSettings_GetSystemMetric( index );
  OUTPUT: RETVAL

MODULE=Wx PACKAGE=Wx::TipProvider

wxTipProvider*
wxTipProvider::new( currentTip )
    size_t currentTip
  CODE:
    RETVAL = new wxPliTipProvider( CLASS, currentTip );
  OUTPUT:
    RETVAL

void
wxTipProvider::Destroy()
  CODE:
    delete THIS;

size_t
wxTipProvider::GetCurrentTip()

void
wxTipProvider::SetCurrentTip( number )
    size_t number
  CODE:
    ((wxPliTipProvider*)THIS)->SetCurrentTip( number );

MODULE=Wx PACKAGE=Wx::Thread

#if wxUSE_THREADS

bool
IsMain()
  CODE:
    RETVAL = wxThread::IsMain();
  OUTPUT:
    RETVAL

#endif

MODULE=Wx PACKAGE=Wx PREFIX=wx

#if WXPERL_W_VERSION_GE( 2, 6, 1 )

bool
wxLaunchDefaultBrowser( url, flags = 0 )
    wxString url
    int flags

#endif

bool
wxShowTip( parent, tipProvider, showAtStartup = true )
    wxWindow* parent
    wxTipProvider* tipProvider
    bool showAtStartup

wxTipProvider*
wxCreateFileTipProvider( filename, currentTip )
    wxString filename
    size_t currentTip

void
wxUsleep( ms )
    unsigned long ms
  CODE:
#if WXPERL_W_VERSION_LE( 2, 5, 2 )
    wxUsleep( ms );
#else
    wxMilliSleep( ms );
#endif

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

void
wxMicroSleep( ms )
    unsigned long ms

#endif

void
wxMilliSleep( ms )
    unsigned long ms
  CODE:
#if WXPERL_W_VERSION_LE( 2, 5, 2 )
    wxUsleep( ms );
#else
    wxMilliSleep( ms );
#endif

void
wxSleep( sec )
    int sec

bool
wxYield()

bool
wxSafeYield( window = 0, onlyIfNeeded = false )
    wxWindow* window
    bool onlyIfNeeded

bool
wxYieldIfNeeded()

void
wxTrap()

wxString
wxGetOsDescription()

long
wxNewId()

wxEventType
wxNewEventType()

void
wxRegisterId( id )
    long id

void
wxBell()

void
wxExit()

bool
wxShell( command = wxEmptyString )
    wxString command

#if WXPERL_W_VERSION_GE( 2, 6, 0 )

bool
wxGetKeyState( key )
    wxKeyCode key

#endif

MODULE=Wx PACKAGE=Wx

void
_utf8_on( sv )
    SV* sv
  CODE:
    SvUTF8_on( sv );

void
_utf8_off( sv )
    SV* sv
  CODE:
    SvUTF8_off( sv );
