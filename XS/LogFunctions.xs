#############################################################################
## Name:        XS/LogFunctions.xs
## Purpose:     XS for logging functions
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Log.xs 2626 2009-10-18 22:48:17Z mbarbon $
## Copyright:   (c) 2000-2003, 2005-2007, 2009 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/log.h>

MODULE=Wx PACKAGE=Wx

# this is a test for INTERFACE:
# in this specific case it saves around 256 bytes / function,
# more for more complex typemaps / longer parameter lists

#if 0

#define XSINTERFACE__wxstring( _ret, _cv, _f ) \
  ( ( void (*)( const wxString& ) ) _f)

#define XSINTERFACE__wxstring_SET( _cv, _f ) \
  ( CvXSUBANY( _cv ).any_ptr = (void*) _f ) 

#undef dXSFUNCTION
#define dXSFUNCTION( a ) \
  void (*XSFUNCTION)( const wxString& )

void
interface__wxstring( string )
    wxString string
  INTERFACE_MACRO:
    XSINTERFACE__wxstring
    XSINTERFACE__wxstring_SET
  INTERFACE:
    wxLogError wxLogFatalError wxLogWarning
    wxLogVerbose wxLogDebug
    wxLogMessage
    
#else

#if WXPERL_W_VERSION_GE( 2, 9, 0 )

void
wxLogError( string )
    wxString string

void
wxLogFatalError( string )
    wxString string

void
wxLogWarning( string )
    wxString string

void
wxLogMessage( string )
    wxString string

void
wxLogVerbose( string )
    wxString string

void
wxLogDebug( string )
    wxString string

#else

void
wxLogError( string )
    const wxChar* string

void
wxLogFatalError( string )
    const wxChar* string

void
wxLogWarning( string )
    const wxChar* string

void
wxLogMessage( string )
    const wxChar* string

void
wxLogVerbose( string )
    const wxChar* string

void
wxLogDebug( string )
    const wxChar* string

#endif

#endif

void
wxLogStatusFrame( frame, string )
    wxFrame* frame
    const wxChar* string
  CODE:
    wxLogStatus( frame, string );

void
wxLogStatus( string )
    const wxChar* string

#if WXPERL_W_VERSION_LE( 2, 5, 0 )

void
wxLogTrace( string )
    const wxChar* string

#endif

void
wxLogTraceMask( mask, string )
    const wxChar* mask
    const wxChar* string
  CODE:
    wxLogTrace( mask, string );

void
wxLogSysError( string )
    const wxChar* string

MODULE=Wx PACKAGE=Wx PREFIX=wx

unsigned long
wxSysErrorCode()

const wxChar*
wxSysErrorMsg( errCode = 0 )
    unsigned long errCode
