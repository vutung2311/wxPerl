/////////////////////////////////////////////////////////////////////////////
// Name:        singlechoicedialog.h
// Purpose:     c++ wrapper for wxSingleChoiceDialog
// Author:      Mattia Barbon
// Modified by:
// Created:     11/ 2/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

// increments reference count of client data upon construction,
// and decrements it upon destruction
class _wxSingleChoiceDialog:public wxSingleChoiceDialog
{
public:
    _wxSingleChoiceDialog( wxWindow* parent, const wxString& message,
                           const wxString& caption, int n,
                           const wxString* choices, SV** clientdata,
                           long style, const wxPoint& pos );
    ~_wxSingleChoiceDialog();
private:
    SV** m_data;
    int m_num;
};

inline _wxSingleChoiceDialog::_wxSingleChoiceDialog( wxWindow* parent, 
                                                     const wxString& message,
                                                     const wxString& caption,
                                                     int n,
                                                     const wxString* choices,
                                                     SV** clientdata,
                                                     long style,
                                                     const wxPoint& pos )
    :wxSingleChoiceDialog( parent, message, caption, n, choices,
                           (char**)clientdata, style, pos )
{
    if( clientdata )
    {
        int i;

        for( i = 0; i < n; ++i )
        {
            SvREFCNT_inc( clientdata[i] );
        }

        m_data = new SV*[ n ];
        m_num = n;
        memcpy( m_data, clientdata, n * sizeof( SV* ) );
    }
}

inline _wxSingleChoiceDialog::~_wxSingleChoiceDialog()
{
    if( m_data )
    {
        int i;

        for( i = 0; i < m_num; ++i )
        {
            SvREFCNT_dec( m_data[i] );
        }

        delete[] m_data;
    }
}

// Local variables: //
// mode: c++ //
// End: //
