#############################################################################
## Name:        Notebook.xs
## Purpose:     XS for Wx::Notebook
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Notebook

Wx_Notebook*
Wx_Notebook::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = "notebook" )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new _wxNotebook( CLASS, parent, id, pos, size, style, name );
  OUTPUT:
    RETVAL

bool
Wx_Notebook::AddPage( page, text, select = FALSE, imageId = -1 )
    Wx_Window* page
    wxString text
    bool select
    int imageId

void
Wx_Notebook::AdvanceSelection( forward = TRUE )
    bool forward

bool
Wx_Notebook::DeleteAllPages()

bool
Wx_Notebook::DeletePage( page )
    int page

Wx_ImageList*
Wx_Notebook::GetImageList()

Wx_Window*
Wx_Notebook::GetPage( page )
    int page

int
Wx_Notebook::GetPageCount()

int
Wx_Notebook::GetPageImage( page )
    int page

wxString
Wx_Notebook::GetPageText( page )
    int page

int
Wx_Notebook::GetRowCount()

int
Wx_Notebook::GetSelection()

bool
Wx_Notebook::InsertPage( index, page, text, select = FALSE, imageId = -1 )
    int index
    Wx_Window* page
    wxString text
    bool select
    int imageId

bool
Wx_Notebook::RemovePage( page )
    int page

void
Wx_Notebook::SetImageList( imagelist )
    Wx_ImageList* imagelist

void
Wx_Notebook::SetPadding( padding )
    Wx_Size padding
#  CODE:
#    THIS->SetPadding( *padding );

void
Wx_Notebook::SetPageSize( padding )
    Wx_Size padding
#  CODE:
#    THIS->SetPageSize( *padding );

bool
Wx_Notebook::SetPageImage( page, image )
    int page
    int image

bool
Wx_Notebook::SetPageText( page, text )
    int page
    wxString text

int
Wx_Notebook::SetSelection( page )
    int page
