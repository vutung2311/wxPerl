/////////////////////////////////////////////////////////////////////////////
// Name:        e_cback.h
// Purpose:     callback helper class for events
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_E_CBACK_H
#define _WXPERL_E_CBACK_H

class WXPLDLL _wxEventCallback:public wxObject
{
public:
    _wxEventCallback( SV* method, SV* self );
    ~_wxEventCallback();

    void Handler( wxEvent& event );
private:
    SV* m_method;
    SV* m_self;
};

#endif // _WXPERL_E_CBACK_H

// Local variables: //
// mode: c++ //
// End: //
