#############################################################################
## Name:        ext/print/XS/Preview.xs
## Purpose:     XS for Wx::PreviewCanvas, Frame & ControlBar
## Author:      Mattia Barbon
## Modified by:
## Created:     02/06/2001
## RCS-ID:      $Id: Preview.xs,v 1.5 2004/03/01 21:24:10 mbarbon Exp $
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/print.h>

MODULE=Wx PACKAGE=Wx::PreviewControlBar

wxPreviewControlBar*
wxPreviewControlBar::new( preview, buttons, parent, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxT("panel") )
    wxPrintPreview* preview
    long buttons
    wxWindow* parent
    wxPoint pos
    wxSize size
    long style
    wxString name

wxPrintPreview*
wxPreviewControlBar::GetPrintPreview()
  CODE:
    RETVAL = (wxPrintPreview*)THIS->GetPrintPreview();
  OUTPUT:
    RETVAL

int
wxPreviewControlBar::GetZoomControl()

void
wxPreviewControlBar::SetZoomControl( zoom )
    int zoom

MODULE=Wx PACKAGE=Wx::PreviewCanvas

wxPreviewCanvas*
wxPreviewCanvas::new( preview, parent, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxT("canvas") )
    wxPrintPreview* preview
    wxWindow* parent
    wxPoint pos
    wxSize size
    long style
    wxString name

MODULE=Wx PACKAGE=Wx::PreviewFrame

wxPreviewFrame*
wxPreviewFrame::new( preview, parent, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxT("frame") )
    wxPrintPreview* preview
    wxFrame* parent
    wxString title
    wxPoint pos
    wxSize size
    long style
    wxString name

void
wxPreviewFrame::Initialize()

