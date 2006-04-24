/////////////////////////////////////////////////////////////////////////////
// Name:        frame.h
// Purpose:     c++ wrapper for wxFrame
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class wxPliFrame:public wxFrame
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliFrame );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliFrame, "Wx::Frame", TRUE );
    WXPLI_CONSTRUCTOR_7( wxPliFrame, "Wx::Frame", TRUE,
                         wxWindow*, wxWindowID, const wxString&,
                         const wxPoint&, const wxSize&, long, 
                         const wxString& );

    virtual wxStatusBar* OnCreateStatusBar( int, long, wxWindowID,
                                            const wxString& );
    virtual wxToolBar* OnCreateToolBar( long, wxWindowID, const wxString& );
};

inline wxStatusBar* wxPliFrame::OnCreateStatusBar( int number, long style,
                                                   wxWindowID id,
                                                   const wxString& name ) 
{
    if( wxPliVirtualCallback_FindCallback( &m_callback,
                                           "OnCreateStatusBar" ) ) 
    {
        SV* ret = wxPliVirtualCallback_CallCallback
            ( &m_callback, G_SCALAR, "illp",
              number, style, id, name.c_str() );
        wxStatusBar* retval =
            (wxStatusBar*)wxPli_sv_2_object( ret, "Wx::StatusBar" );
        SvREFCNT_dec( ret );

        return retval;
    } else
        return wxFrame::OnCreateStatusBar( number, style, id, name );
}

inline wxToolBar* wxPliFrame::OnCreateToolBar( long style, wxWindowID id,
                                               const wxString& name )
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "OnCreateToolBar" ) ) 
    {
        SV* ret = wxPliVirtualCallback_CallCallback
            ( &m_callback, G_SCALAR, "llp",
              style, id, name.c_str() );
        wxToolBar* retval =
            (wxToolBar*)wxPli_sv_2_object( ret, "Wx::ToolBarSimple" );
        SvREFCNT_dec( ret );

        return retval;
    } else
        return wxFrame::OnCreateToolBar( style, id, name );
}
    
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliFrame, wxFrame );

WXPLI_DECLARE_CLASS_7( MiniFrame, TRUE,
                       wxWindow*, wxWindowID, const wxString&,
                       const wxPoint&, const wxSize&, long,
                       const wxString& );

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliMiniFrame, wxMiniFrame );

// Local variables: //
// mode: c++ //
// End: //