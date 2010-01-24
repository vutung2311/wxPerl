/////////////////////////////////////////////////////////////////////////////
// Name:        Core.xs
// Purpose:     define some core functions required for a minimal bootstrap
// Author:      Mattia Barbon
// Modified by:
// Created:     24/01/2010
// RCS-ID:      $Id$
// Copyright:   (c) 2009-2010 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#define WXPLI_DELAY_LOAD 1

#define DECLARE_PACKAGE( package ) \
  static bool wxPli_##package##_booted = false; \
  XS( boot_Wx_##package )
#define DECLARE_MODULE( module ) \
  static bool wxPli_##module##_booted = false; \
  XS( boot_Wx_##module )

#if WXPLI_DELAY_LOAD
#define LOAD_PACKAGE( package ) \
  wxPli_delay_load( aTHX_ "Wx::" #package, boot_Wx_##package, &wxPli_##package##_booted )
#define LOAD_PACKAGE2( boot, package ) \
  wxPli_delay_load( aTHX_ "Wx::" #package, boot_Wx_##boot, &wxPli_##boot##_booted )
#define LOAD_MODULE( module, package ) \
  wxPli_delay_module( aTHX_ "Wx::" #package, "Wx::" #module, &wxPli_##module##_booted )
#else
#define LOAD_PACKAGE( package ) \
  wxPli_call_boot( aTHX_ "Wx::" #package, boot_Wx_##package, &wxPli_##package##_booted )
#define LOAD_PACKAGE2( boot, package ) \
  wxPli_call_boot( aTHX_ "Wx::" #package, boot_Wx_##boot, &wxPli_##boot##_booted )
#define LOAD_MODULE( module, package )
#define 
#endif

#include "cpp/delayload.cpp"

extern "C" {
    XS( boot_Wx_Const );
    XS( boot_Wx_Ctrl );
    XS( boot_Wx_Evt );
    XS( boot_Wx_Win );
    XS( boot_Wx_Wnd );
    XS( boot_Wx_GDI );
    XS( boot_Wx_Threading );
    XS( boot_Wx_Misc );
#if defined( WXPL_STATIC )
    XS( boot_Wx__DocView );
#if wxPERL_USE_STC
    XS( boot_Wx__STC );
#endif
#if wxPERL_USE_XRC
    XS( boot_Wx__XRC );
#endif
    XS( boot_Wx__Print );
    XS( boot_Wx__MDI );
    XS( boot_Wx__Html );
    XS( boot_Wx__Help );
    XS( boot_Wx__Grid );
    XS( boot_Wx__FS );
    XS( boot_Wx__DND );
#endif
}

WXPLI_BOOT_ONCE_EXP(Wx);
#define boot_Wx wxPli_boot_Wx

DEFINE_PLI_HELPERS( st_wxPliHelpers );

MODULE=Wx PACKAGE=Wx

BOOT:
  const char *file = __FILE__;

  newXSproto( "Wx::_boot_Constant", boot_Wx_Const, file, "$$" );
  newXSproto( "Wx::_boot_Controls", boot_Wx_Ctrl, file, "$$" );
  newXSproto( "Wx::_boot_Events", boot_Wx_Evt, file, "$$" );
  newXSproto( "Wx::_boot_Window", boot_Wx_Win, file, "$$" );
  newXSproto( "Wx::_boot_Frames", boot_Wx_Wnd, file, "$$" );
  newXSproto( "Wx::_boot_GDI", boot_Wx_GDI, file, "$$" );
  newXSproto( "Wx::_boot_Threading", boot_Wx_Threading, file, "$$" );
  newXSproto( "Wx::_boot_Misc", boot_Wx_Misc, file, "$$" );
#if defined( WXPL_STATIC )
  newXSproto( "Wx::_boot_Wx__DocView", boot_Wx__DocView, file, "$$" );
#if wxPERL_USE_STC
  newXSproto( "Wx::_boot_Wx__STC", boot_Wx__STC, file, "$$" );
#endif
#if wxPERL_USE_XRC
  newXSproto( "Wx::_boot_Wx__XRC", boot_Wx__XRC, file, "$$" );
#endif
  newXSproto( "Wx::_boot_Wx__Print", boot_Wx__Print, file, "$$" );
  newXSproto( "Wx::_boot_Wx__MDI", boot_Wx__MDI, file, "$$" );
  newXSproto( "Wx::_boot_Wx__Html", boot_Wx__Html, file, "$$" );
  newXSproto( "Wx::_boot_Wx__Help", boot_Wx__Help, file, "$$" );
  newXSproto( "Wx::_boot_Wx__Grid", boot_Wx__Grid, file, "$$" );
  newXSproto( "Wx::_boot_Wx__FS", boot_Wx__FS, file, "$$" );
  newXSproto( "Wx::_boot_Wx__DND", boot_Wx__DND, file, "$$" );
#endif
  SV* tmp = get_sv( "Wx::_exports", 1 );
  sv_setiv( tmp, (IV)(void*)&st_wxPliHelpers );

  DelayLoadModules(aTHX);
