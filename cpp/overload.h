/////////////////////////////////////////////////////////////////////////////
// Name:        overload.h
// Purpose:     C++ code to redispatch a function based on function argument
//              types
// Author:      Mattia Barbon
// Modified by:
// Created:     11/ 8/2002
// RCS-ID:      
// Copyright:   (c) 2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/ovl_const.h"

#define BEGIN_OVERLOAD() \
    PUSHMARK(MARK); \
    int count;

#define END_OVERLOAD( FUNCTION ) \
    { \
        static const char msg[] = "unable to resolve overloaded method for "; \
        require_pv( "Carp" ); \
        const char* argv[3]; argv[0] = msg; argv[1] = #FUNCTION; argv[2] = 0; \
        call_argv( "Carp::croak", G_VOID|G_DISCARD, (char**) argv ); \
    } \
    /* POPMARK; */

#define REDISPATCH( NEW_METHOD_NAME ) \
    count = call_method( #NEW_METHOD_NAME, GIMME_V ); SPAGAIN

#define MATCH_VOID_REDISP( METHOD ) \
    if( items == 0 ) \
        { REDISPATCH( METHOD ); } \
    else

#define MATCH_ANY_REDISP( METHOD ) \
    if( TRUE ) \
        { REDISPATCH( METHOD ); } \
    else

#define MATCH_REDISP( PROTO, METHOD ) \
    if( wxPli_match_arguments_skipfirst( aTHX_ PROTO, PROTO##_count ) ) \
        { REDISPATCH( METHOD ); } \
    else

#define MATCH_REDISP_COUNT( PROTO, METHOD, REQUIRED ) \
    if( wxPli_match_arguments_skipfirst( aTHX_ PROTO, PROTO##_count, \
                                         REQUIRED ) ) \
        { REDISPATCH( METHOD ); } \
    else

#define MATCH_REDISP_COUNT_ALLOWMORE( PROTO, METHOD, REQUIRED ) \
    if( wxPli_match_arguments_skipfirst( aTHX_ PROTO, PROTO##_count, \
                                         REQUIRED, TRUE ) ) \
        { REDISPATCH( METHOD ); } \
    else
