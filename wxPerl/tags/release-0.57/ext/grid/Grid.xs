/////////////////////////////////////////////////////////////////////////////
// Name:        ext/grid/Grid.xs
// Purpose:     XS for Wx::Grid
// Author:      Mattia Barbon
// Modified by:
// Created:     04/12/2001
// RCS-ID:      $Id: Grid.xs,v 1.16 2006/08/19 18:53:45 mbarbon Exp $
// Copyright:   (c) 2001-2004, 2006 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#undef THIS

#include <wx/grid.h>
typedef wxGrid::wxGridSelectionModes wxGridSelectionModes;
typedef wxGridCellAttr::wxAttrKind wxAttrKind;

MODULE=Wx__Grid

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: XS/Grid.xs
INCLUDE: XS/GridCellAttr.xs
INCLUDE: XS/GridEvent.xs
INCLUDE: XS/GridCellRenderer.xs
INCLUDE: XS/GridCellEditor.xs

INCLUDE: perl ../../script/wx_xspp.pl -t ../../typemap.xsp XS/GridTable.xsp |

INCLUDE: perl ../../script/wx_xspp.pl -t ../../typemap.xsp XS/GridTableMessage.xsp |

#include "cpp/gr_constants.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__Grid