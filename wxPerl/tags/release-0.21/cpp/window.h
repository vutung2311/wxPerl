/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/window.h
// Purpose:     c++ wrapper for wxWindow
// Author:      Mattia Barbon
// Modified by:
// Created:     03/11/2000
// RCS-ID:      $Id: window.h,v 1.5 2004/08/04 20:13:55 mbarbon Exp $
// Copyright:   (c) 2000-2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

WXPLI_DECLARE_CLASS_6( Window, true,
                       wxWindow*, wxWindowID, const wxPoint&,
                       const wxSize&, long, const wxString& );

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliWindow, wxWindow );

// local variables:
// mode: c++
// end:
