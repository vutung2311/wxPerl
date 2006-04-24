/////////////////////////////////////////////////////////////////////////////
// Name:        controls.h
// Purpose:     c++ wrappers for wxControl-derived classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_CONTROLS_H
#define _WXPERL_CONTROLS_H

WXPLI_DECLARE_CLASS_8( Button, TRUE,
                       wxWindow*, wxWindowID, const wxString&,
                       const wxPoint&, const wxSize&, long, 
                       const wxValidator&, const wxString& );
WXPLI_DECLARE_CLASS_8( BitmapButton, TRUE,
                       wxWindow*, wxWindowID,
                       const wxBitmap&, const wxPoint&, const wxSize&, long,
                       const wxValidator&, const wxString );
WXPLI_DECLARE_CLASS_8( CheckBox, TRUE,
                       wxWindow*, wxWindowID, const wxString&, 
                       const wxPoint&, const wxSize&, long, 
                       const wxValidator&, const wxString& );
WXPLI_DECLARE_CLASS_9( CheckListBox, TRUE,
                       wxWindow*, wxWindowID, const wxPoint&,
                       const wxSize&, int, const wxString*, long, 
                       const wxValidator&, const wxString& );
WXPLI_DECLARE_CLASS_9( Choice, TRUE,
                       wxWindow*, wxWindowID, const wxPoint&,
                       const wxSize&, int, const wxString*, long, 
                       const wxValidator&, const wxString& );
WXPLI_DECLARE_CLASS_10( ComboBox, TRUE,
                        wxWindow*, wxWindowID, const wxString&,
                        const wxPoint&, const wxSize&, int,
                        const wxString*, long, const wxValidator&, 
                        const wxString& );
WXPLI_DECLARE_CLASS_8( Gauge, TRUE,
                       wxWindow*, wxWindowID, int, const wxPoint&,
                       const wxSize&, long, const wxValidator&,
                       const wxString& );
WXPLI_DECLARE_CLASS_9( ListBox, TRUE,
                       wxWindow*, wxWindowID, const wxPoint&,
                       const wxSize&, int, const wxString*, long, 
                       const wxValidator&, const wxString& );
WXPLI_DECLARE_CLASS_7( ListCtrl, TRUE,
                       wxWindow*, wxWindowID, const wxPoint&,
                       const wxSize&, long, const wxValidator&,
                       const wxString& );
WXPLI_DECLARE_CLASS_6( Notebook, TRUE,
                       wxWindow*, wxWindowID, const wxPoint&,
                       const wxSize&, long, const wxString& );

class wxPliRadioBox:public wxRadioBox
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliRadioBox );
    WXPLI_DECLARE_SELFREF();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliRadioBox, "Wx::RadioBox", TRUE );
    WXPLI_CONSTRUCTOR_11( wxPliRadioBox, "Wx::RadioBox", TRUE,
                          wxWindow*, wxWindowID, const wxString&,
                          const wxPoint&, const wxSize&, int,
                          const wxString*, int, long, 
                          const wxValidator&, const wxString& );
};

WXPLI_DECLARE_CLASS_8( RadioButton, TRUE,
                       wxWindow*, wxWindowID, const wxString,
                       const wxPoint&, const wxSize&, long,
                       const wxValidator&, const wxString& );
WXPLI_DECLARE_CLASS_7( ScrollBar, TRUE,
                       wxWindow*, wxWindowID, const wxPoint&,
                       const wxSize&, long, const wxValidator&,
                       const wxString& );
WXPLI_DECLARE_CLASS_6( SpinButton, TRUE,
                       wxWindow*, wxWindowID, const wxPoint&,
                       const wxSize&, long, const wxString& );
WXPLI_DECLARE_CLASS_10( SpinCtrl, TRUE,
                        wxWindow*, wxWindowID, const wxString&,
                        const wxPoint&, const wxSize&, long,
                        int, int, int, const wxString& );
WXPLI_DECLARE_CLASS_10( Slider, TRUE,
                        wxWindow*, wxWindowID, int, int, int,
                        const wxPoint&, const wxSize&, long,
                        const wxValidator&, const wxString& );
WXPLI_DECLARE_CLASS_7( StaticBitmap, TRUE,
                       wxWindow*, wxWindowID, const wxBitmap&,
                       const wxPoint&, const wxSize&, long,
                       const wxString& );
WXPLI_DECLARE_CLASS_7( StaticBox, TRUE,
                       wxWindow*, wxWindowID, const wxString&,
                       const wxPoint&, const wxSize&, long,
                       const wxString& );
WXPLI_DECLARE_CLASS_6( StaticLine, TRUE,
                       wxWindow*, wxWindowID, const wxPoint&,
                       const wxSize&, long, const wxString& );
WXPLI_DECLARE_CLASS_7( StaticText, TRUE,
                       wxWindow*, wxWindowID, const wxString&,
                       const wxPoint&, const wxSize&, long,
                       const wxString& );
WXPLI_DECLARE_CLASS_8( TextCtrl, TRUE,
                       wxWindow*, wxWindowID, const wxString&,
                       const wxPoint&, const wxSize&, long,
                       const wxValidator&, const wxString& );

class wxPliTreeCtrl:public wxTreeCtrl
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliTreeCtrl );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliTreeCtrl, "Wx::TreeCtrl", TRUE );
    WXPLI_CONSTRUCTOR_7( wxPliTreeCtrl, "Wx::TreeCtrl", TRUE,
                         wxWindow*, wxWindowID, const wxPoint&,
                         const wxSize&, long, const wxValidator&,
                         const wxString& );

    int OnCompareItems( const wxTreeItemId& item1,
                        const wxTreeItemId& item2 );
};

#endif // _WXPERL_CONTROLS_H

// Local variables: //
// mode: c++ //
// End: //