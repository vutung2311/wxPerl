#############################################################################
## Name:        ext/html/XS/HtmlEasyPrinting.xs
## Purpose:     XS for Wx::HtmlEasyPrinting
## Author:      Mattia Barbon
## Modified by:
## Created:     04/05/2001
## RCS-ID:      $Id: HtmlEasyPrinting.xs,v 1.9 2006/08/11 19:54:59 mbarbon Exp $
## Copyright:   (c) 2001-2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/html/htmprint.h>

MODULE=Wx PACKAGE=Wx::HtmlEasyPrinting

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

wxHtmlEasyPrinting*
wxHtmlEasyPrinting::new( wxString name = wxT("Printing"), \
                         wxWindow* parent = 0 )

#else

wxHtmlEasyPrinting*
wxHtmlEasyPrinting::new( name = wxT("Printing"), parent_frame = 0 )
    wxString name
    wxFrame* parent_frame

#endif

## // thread KO
void
wxHtmlEasyPrinting::DESTROY()

bool
wxHtmlEasyPrinting::PreviewFile( htmlFile )
    wxString htmlFile

bool
wxHtmlEasyPrinting::PreviewText( htmlText, basepath = wxEmptyString )
    wxString htmlText
    wxString basepath

bool
wxHtmlEasyPrinting::PrintFile( htmlFile )
    wxString htmlFile

bool
wxHtmlEasyPrinting::PrintText( htmlText, basepath = wxEmptyString )
    wxString htmlText
    wxString basepath

#if WXPERL_W_VERSION_LE( 2, 5, 2 )

void
wxHtmlEasyPrinting::PrinterSetup()

#endif

void
wxHtmlEasyPrinting::PageSetup()

void
wxHtmlEasyPrinting::SetHeader( header, pg = wxPAGE_ALL )
    wxString header
    int pg

void
wxHtmlEasyPrinting::SetFooter( header, pg = wxPAGE_ALL )
    wxString header
    int pg

wxPrintData*
wxHtmlEasyPrinting::GetPrintData()

wxPageSetupDialogData*
wxHtmlEasyPrinting::GetPageSetupData()
