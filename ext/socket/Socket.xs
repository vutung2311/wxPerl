/////////////////////////////////////////////////////////////////////////////
// Name:        Socket.xs
// Purpose:     XS for Wx::Socket
// Author:      Graciliano M. P.
// Modified by:
// Created:     27/02/2003
// RCS-ID:      
// Copyright:   (c) 2003 Graciliano M. P.
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "wx/socket.h"

#undef THIS

#include "cpp/sk_constants.cpp"
#include "cpp/socket.h"

MODULE=Wx__Socket

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );
  // wxClassInfo::CleanUpClasses();
  // wxClassInfo::InitializeClasses();

INCLUDE: XS/SocketBase.xs
INCLUDE: XS/SocketClient.xs
INCLUDE: XS/SocketServer.xs
INCLUDE: XS/SocketEvent.xs

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__Socket

