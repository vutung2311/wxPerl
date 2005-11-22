#############################################################################
## Name:        XS/Dialog.xs
## Purpose:     XS for Wx::Dialog
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Dialog.xs,v 1.13 2005/11/22 22:31:57 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003-2004 Mattia Barbon
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
      wxWindow* parent
      wxWindowID id
      wxString title
      wxPoint pos
      wxSize size
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
wxDialog::EndModal( retCode )
    int retCode

int
wxDialog::GetReturnCode()

wxString
wxDialog::GetTitle()

void
wxDialog::Iconize( iconize )
    bool iconize

bool
wxDialog::IsIconized()

bool
wxDialog::IsModal()

# void
# wxDialog::SetModal( flag )
#    bool flag

#if (WXPERL_W_VERSION_GE( 2, 4, 1 ) && !defined(__WXMOTIF__)) \
    || WXPERL_W_VERSION_GE( 2, 5, 1 )

void
wxDialog::SetShape( region )
  wxRegion* region
  C_ARGS: *region

#endif

void
wxDialog::SetIcon( icon )
    wxIcon* icon
  C_ARGS: *icon

void
wxDialog::SetIcons( icons )
    wxIconBundle* icons
  C_ARGS: *icons

void
wxDialog::SetReturnCode( retCode )
    int retCode

void
wxDialog::SetTitle( title )
    wxString title

int
wxDialog::ShowModal()

bool
wxDialog::TransferDataFromWindow()
  CODE:
    RETVAL = THIS->wxDialog::TransferDataFromWindow();
  OUTPUT:
    RETVAL

bool
wxDialog::TransferDataToWindow()
  CODE:
    RETVAL = THIS->wxDialog::TransferDataToWindow();
  OUTPUT:
    RETVAL

bool
wxDialog::Validate()
  CODE:
    RETVAL = THIS->wxDialog::Validate();
  OUTPUT:
    RETVAL
