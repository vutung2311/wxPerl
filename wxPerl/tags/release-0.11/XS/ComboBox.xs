#############################################################################
## Name:        Notebook.xs
## Purpose:     XS for Wx::ComboBox
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::ComboBox

Wx_ComboBox*
Wx_ComboBox::new( parent, id, value, pos, size , choices, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxComboBoxNameStr )
    Wx_Window* parent
    wxWindowID id
    wxString value
    Wx_Point pos
    Wx_Size size
    SV* choices
    long style
    Wx_Validator* validator
    wxString name
  PREINIT:
    wxString* chs;
    int n;
  CODE:
    n = wxPli_av_2_stringarray( aTHX_ choices, &chs );
    RETVAL = new wxPliComboBox( CLASS, parent, id, value, pos, size, n, chs, 
        style, *validator, name );

    delete[] chs;
  OUTPUT:
    RETVAL

void
Wx_ComboBox::Clear()

#if defined( __WXGTK__ ) || defined( __WXPERL_FORCE__ )

void
Wx_ComboBox::AppendString( item )
    wxString item
  CODE:
    THIS->Append( item );

void
Wx_ComboBox::AppendData( item, data )
    wxString item
    Wx_UserDataCD* data
  CODE:
    THIS->Append( item, data );

void
Wx_ComboBox::Delete( n )
    int n

int
Wx_ComboBox::FindString( string )
    wxString string

int
Wx_ComboBox::GetSelection()

wxString
Wx_ComboBox::GetString( n )
    int n

wxString
Wx_ComboBox::GetStringSelection()

void
Wx_ComboBox::SetStringSelection( string )
    wxString string

Wx_UserDataCD*
Wx_ComboBox::GetClientData( n )
    int n
  CODE:
    RETVAL = (Wx_UserDataCD*) THIS->GetClientObject( n );
  OUTPUT:
    RETVAL

void
Wx_ComboBox::SetClientData( n, data )
    int n
    Wx_UserDataCD* data
  CODE:
    THIS->SetClientObject( n, data );

#endif

void
Wx_ComboBox::Copy()

void
Wx_ComboBox::Cut()

long
Wx_ComboBox::GetInsertionPoint()

long
Wx_ComboBox::GetLastPosition()

wxString
Wx_ComboBox::GetValue()

void
Wx_ComboBox::Paste()

void
Wx_ComboBox::Replace( from, to, text )
    long from
    long to
    wxString text

void
Wx_ComboBox::Remove( from ,to )
    long from
    long to

void
Wx_ComboBox::SetInsertionPoint( pos )
    long pos

void
Wx_ComboBox::SetInsertionPointEnd()

void
Wx_ComboBox::SetSelectionN( n )
    int n
  CODE:
    THIS->SetSelection( n );

void
Wx_ComboBox::SetMark( from, to )
    long from
    long to
  CODE:
    THIS->SetSelection( from, to );

void
Wx_ComboBox::SetValue( string )
    wxString string
