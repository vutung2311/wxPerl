/////////////////////////////////////////////////////////////////////////////
// Name:        ext/datetime/DateTime.xs
// Purpose:     XS for Wx::DateTime
// Author:      Mattia Barbon
// Modified by:
// Created:     22/09/2002
// RCS-ID:      $Id$
// Copyright:   (c) 2002, 2006, 2008 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#undef THIS

MODULE=Wx__DateTime

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: xspp -t ../../typemap.xsp XS/DateTime.xsp |

INCLUDE: xspp -t ../../typemap.xsp XS/DateSpan.xsp |

INCLUDE: xspp -t ../../typemap.xsp XS/TimeSpan.xsp |

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__DateTime