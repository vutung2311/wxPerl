#############################################################################
## Name:        XS/TaskBarIcon.xs
## Purpose:     XS for Wx::TaskBarIcon
## Author:      Mattia Barbon
## Modified by:
## Created:     03/12/2001
## RCS-ID:      $Id: TaskBarIcon.xs,v 1.2 2004/02/28 22:59:06 mbarbon Exp $
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::TaskBarIcon

#if defined(__WXMSW__)

#include <wx/taskbar.h>

Wx_TaskBarIcon*
Wx_TaskBarIcon::new()

void
Wx_TaskBarIcon::Destroy()
  CODE:
    delete THIS;

bool
Wx_TaskBarIcon::IsIconInstalled()

bool
Wx_TaskBarIcon::SetIcon( icon, tooltip = wxEmptyString )
    Wx_Icon* icon
    wxString tooltip
  CODE:
    RETVAL = THIS->SetIcon( *icon, tooltip );
  OUTPUT:
    RETVAL

bool
Wx_TaskBarIcon::RemoveIcon()

bool
Wx_TaskBarIcon::PopupMenu( menu )
    wxMenu* menu

#endif
