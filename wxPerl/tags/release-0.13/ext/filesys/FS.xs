/////////////////////////////////////////////////////////////////////////////
// Name:        FS.xs
// Purpose:     XS for Wx::FileSystem and related classes
// Author:      Mattia Barbon
// Modified by:
// Created:     28/ 4/2001
// RCS-ID:      
// Copyright:   (c) 2001-2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/typedef.h"
#include "cpp/fs_typedef.h"

#undef THIS

MODULE=Wx__FS

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: XS/FileSystem.xs
INCLUDE: XS/FileSystemHandler.xs
INCLUDE: XS/FSFile.xs

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__FS
