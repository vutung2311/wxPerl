#############################################################################
## Name:        XS/Dialog.xs
## Purpose:     XS for Wx::Dialog
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Dialog.xs,v 1.9 2003/06/04 20:38:41 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/dialog.h>
#include <wx/button.h>
#include "cpp/dialog.h"

MODULE=Wx PACKAGE=Wx::Dialog

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::Dialog::new" )

wxDialog*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxPliDialog( CLASS );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxDialog*
newFull( CLASS, parent, id = -1, title = wxEmptyString, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_DIALOG_STYLE, name = wxDialogNameStr )
      PlClassName CLASS
      Wx_Window* parent
      wxWindowID id
      wxString title
      Wx_Point pos
      Wx_Size size
      long style
      wxString name
    CODE:
      RETVAL = new wxPliDialog( CLASS, parent, id, title, pos,
          size, style, name );
    OUTPUT:
      RETVAL

bool
wxDialog::Create( parent, id = -1, title = wxEmptyString, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_DIALOG_STYLE, name = wxDialogNameStr )
    wxWindow* parent
    wxWindowID id
    wxString title
    wxPoint pos
    wxSize size
    long style
    wxString name

void
Wx_Dialog::EndModal( retCode )
    int retCode

int
Wx_Dialog::GetReturnCode()

void
Wx_Dialog::Iconize( iconize )
    bool iconize

bool
Wx_Dialog::IsIconized()

bool
Wx_Dialog::IsModal()

# void
# Wx_Dialog::SetModal( flag )
#    bool flag

#if (WXPERL_W_VERSION_GE( 2, 4, 1 ) && !defined(__WXMOTIF__)) \
    || WXPERL_W_VERSION_GE( 2, 5, 0 )

void
wxDialog::SetShape( region )
  wxRegion* region
  C_ARGS: *region

#endif

void
Wx_Dialog::SetReturnCode( retCode )
    int retCode

int
Wx_Dialog::ShowModal()

bool
Wx_Dialog::TransferDataFromWindow()
  CODE:
    RETVAL = THIS->wxDialog::TransferDataFromWindow();
  OUTPUT:
    RETVAL

bool
Wx_Dialog::TransferDataToWindow()
  CODE:
    RETVAL = THIS->wxDialog::TransferDataToWindow();
  OUTPUT:
    RETVAL

bool
Wx_Dialog::Validate()
  CODE:
    RETVAL = THIS->Validate();
  OUTPUT:
    RETVAL
