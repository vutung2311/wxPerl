#############################################################################
## Name:        FileDialog.xs
## Purpose:     XS for Wx::FileDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     27/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::FileDialog

Wx_FileDialog*
Wx_FileDialog::new( parent, message = wxFileSelectorPromptStr, defaultDir = wxEmptyString, defaultFile = wxEmptyString, wildcard = wxFileSelectorDefaultWildcardStr, style = 0, pos = wxDefaultPosition )
    Wx_Window* parent
    wxString message
    wxString defaultDir
    wxString defaultFile
    wxString wildcard
    long style
    Wx_Point pos

wxString
Wx_FileDialog::GetDirectory()

wxString
Wx_FileDialog::GetFilename()

void
Wx_FileDialog::GetFilenames()
  PREINIT:
    wxArrayString filenames;
    int i, max;
    char* t;
  PPCODE:
    THIS->GetFilenames( filenames );
    max = filenames.GetCount();
    EXTEND( SP, max );
    for( i = 0; i < max; ++i ) {
      t = (char*)(const char*) filenames[i];
      PUSHs( sv_2mortal( newSVpv( t, 0 ) ) );
    }

int
Wx_FileDialog::GetFilterIndex()

wxString
Wx_FileDialog::GetMessage()

wxString
Wx_FileDialog::GetPath()

void
Wx_FileDialog::GetPaths()
  PREINIT:
    wxArrayString filenames;
    int i, max;
    char* t;
  PPCODE:
    THIS->GetPaths( filenames );
    max = filenames.GetCount();
    EXTEND( SP, max );
    for( i = 0; i < max; ++i ) {
      t = (char*)(const char*) filenames[i];
      PUSHs( sv_2mortal( newSVpv( t, 0  ) ) );
    }

long
Wx_FileDialog::GetStyle()

wxString
Wx_FileDialog::GetWildcard()

void
Wx_FileDialog::SetDirectory( directory )
    wxString directory

void
Wx_FileDialog::SetFilename( name )
    wxString name

void
Wx_FileDialog::SetFilterIndex( index )
    int index

void
Wx_FileDialog::SetMessage( message )
    wxString message

void
Wx_FileDialog::SetPath( path )
    wxString path

void
Wx_FileDialog::SetStyle( style )
    long style

void
Wx_FileDialog::SetWildcard( wildcard )
    wxString wildcard

int
Wx_FileDialog::ShowModal()
