#############################################################################
## Name:        ext/print/XS/PageSetupDialog.xs
## Purpose:     XS for Wx::PageSetupDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     04/05/2001
## RCS-ID:      $Id: PageSetupDialog.xs,v 1.2 2004/03/01 21:24:10 mbarbon Exp $
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/printdlg.h>

MODULE=Wx PACKAGE=Wx::PageSetupDialog

wxPageSetupDialog*
wxPageSetupDialog::new( parent, data = 0 )
    wxWindow* parent
    wxPageSetupDialogData* data

void
wxPageSetupDialog::Destroy()
  CODE:
    delete THIS;

wxPageSetupDialogData*
wxPageSetupDialog::GetPageSetupData()
  CODE:
    RETVAL = &THIS->GetPageSetupData();
  OUTPUT:
    RETVAL

