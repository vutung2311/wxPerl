/////////////////////////////////////////////////////////////////////////////
// Name:        v_cback.h
// Purpose:     callback helper class for virtual functions
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_V_CBACK_H
#define _WXPERL_V_CBACK_H

class WXPLDLL wxPliVirtualCallback:public wxPliSelfRef
{
public:
    wxPliVirtualCallback( const char* package );

    bool FindCallback( const char* name );
    SV* CallCallback( I32 flags, const char* argtypes,
                      va_list& arglist );
    SV* GetMethod() { return m_method; }
public:
    const char* m_package;
    HV* m_stash;
    SV* m_method;
};

inline wxPliVirtualCallback::wxPliVirtualCallback( const char* package ) {
    m_package = package;
    m_self = 0;
    m_stash = 0;
}

// declare/define callbacks for commonly used signatures

#define DEC_V_CBACK_BOOL__VOID( METHOD ) \
  bool METHOD();

#define DEC_V_CBACK_VOID__VOID( METHOD ) \
  void METHOD();

#define DEC_V_CBACK_BOOL__INT( METHOD ) \
  bool METHOD( int );

#define DEC_V_CBACK_BOOL__INT_INT( METHOD ) \
  bool METHOD( int, int );

#define DEF_V_CBACK_BOOL__VOID( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD()                                                        \
  {                                                                           \
    if( wxPliVirtualCallback_FindCallback( &m_callback, #METHOD ) )           \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR ); \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return BASE::METHOD();                                                \
  }

#define DEF_V_CBACK_VOID__VOID( CLASS, BASE, METHOD ) \
  void CLASS::METHOD()                                                        \
  {                                                                           \
    if( wxPliVirtualCallback_FindCallback( &m_callback, #METHOD ) )           \
    {                                                                         \
        wxPliVirtualCallback_CallCallback( &m_callback,                       \
                                           G_SCALAR|G_DISCARD );              \
    } else                                                                    \
        BASE::METHOD();                                                \
  }

#define DEF_V_CBACK_BOOL__INT( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( int parameter )                                         \
  {                                                                           \
    if( wxPliVirtualCallback_FindCallback( &m_callback, #METHOD ) )           \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR,   \
                                                     "i", parameter );        \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return BASE::METHOD( parameter );                                     \
  }

#define DEF_V_CBACK_BOOL__INT_pure( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( int parameter )                                         \
  {                                                                           \
    if( wxPliVirtualCallback_FindCallback( &m_callback, #METHOD ) )           \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR,   \
                                                     "i", parameter );        \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    }                                                                         \
    return false;                                                             \
  }

#define DEF_V_CBACK_BOOL__INT_INT( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( int param1, int param2 )                                \
  {                                                                           \
    if( wxPliVirtualCallback_FindCallback( &m_callback, #METHOD ) )           \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR,   \
                                                     "ii", param1, param2 );  \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return BASE::METHOD( param1, param2 );                                \
  }

#endif // _WXPERL_V_CBACK_H

// Local variables: //
// mode: c++ //
// End: //
