#############################################################################
## Name:        XS/MessageDialog.xs
## Purpose:     XS for Wx::MessageDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     27/11/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/msgdlg.h>

MODULE=Wx PACKAGE=Wx::MessageDialog

wxMessageDialog*
wxMessageDialog::new( parent, message, caption = wxMessageBoxCaptionStr, style = wxOK|wxCANCEL|wxCENTRE, pos = wxDefaultPosition )
    wxWindow* parent
    wxString message
    wxString caption
    long style
    wxPoint pos

int
wxMessageDialog::ShowModal()

MODULE=Wx PACKAGE=Wx PREFIX=wx

int
wxMessageBox( message, caption = wxT("Message"), style = wxOK|wxCENTRE, parent = 0, x = -1, y = -1 )
    wxString message
    wxString caption
    int style
    wxWindow* parent
    int x
    int y


