#############################################################################
## Name:        XS/Config.xs
## Purpose:     XS for Wx::*Config*
## Author:      Mattia Barbon
## Modified by:
## Created:     13/12/2001
## RCS-ID:      $Id: Config.xs,v 1.4 2004/02/29 14:43:23 mbarbon Exp $
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/confbase.h>

MODULE=Wx PACKAGE=Wx::ConfigBase

void
wxConfigBase::Destroy()
  CODE:
    delete THIS;

wxConfigBase*
Create()
  CODE:
    RETVAL = wxConfigBase::Create();
  OUTPUT:
    RETVAL

void
DontCreateOnDemand()
  CODE:
    wxConfigBase::DontCreateOnDemand();

bool
wxConfigBase::DeleteAll()

bool
wxConfigBase::DeleteEntry( key, deleteGroupIfEmpty = TRUE )
    wxString key
    bool deleteGroupIfEmpty

bool
wxConfigBase::DeleteGroup( key )
    wxString key

bool
wxConfigBase::Exists( key )
    wxString key

bool
wxConfigBase::Flush( currentOnly = FALSE )
    bool currentOnly

wxConfigBase*
Get( createOnDemand = TRUE )
    bool createOnDemand
  CODE:
    RETVAL = wxConfigBase::Get( createOnDemand );
  OUTPUT:
    RETVAL

wxString
wxConfigBase::GetAppName()

EntryType
wxConfigBase::GetEntryType( name )
    wxString name

void
wxConfigBase::GetFirstEntry()
  PREINIT:
    wxString name;
    long index;
    bool ret;
  PPCODE:
    ret = THIS->GetFirstEntry( name, index );
    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( ret ) ) );
    SV* tmp = newSViv( 0 );
    WXSTRING_OUTPUT( name, tmp );
    PUSHs( sv_2mortal( tmp ) );
    PUSHs( sv_2mortal( newSViv( index ) ) );

void
wxConfigBase::GetFirstGroup()
  PREINIT:
    wxString name;
    long index;
    bool ret;
  PPCODE:
    ret = THIS->GetFirstGroup( name, index );
    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( ret ) ) );
    SV* tmp = newSViv( 0 );
    WXSTRING_OUTPUT( name, tmp );
    PUSHs( sv_2mortal( tmp ) );
    PUSHs( sv_2mortal( newSViv( index ) ) );

void
wxConfigBase::GetNextEntry( index )
    long index
  PREINIT:
    wxString name;
    bool ret;
  PPCODE:
    ret = THIS->GetNextEntry( name, index );
    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( ret ) ) );
    SV* tmp = newSViv( 0 );
    WXSTRING_OUTPUT( name, tmp );
    PUSHs( sv_2mortal( tmp ) );
    PUSHs( sv_2mortal( newSViv( index ) ) );

void
wxConfigBase::GetNextGroup( index )
    long index
  PREINIT:
    wxString name;
    bool ret;
  PPCODE:
    ret = THIS->GetNextGroup( name, index );
    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( ret ) ) );
    SV* tmp = newSViv( 0 );
    WXSTRING_OUTPUT( name, tmp );
    PUSHs( sv_2mortal( tmp ) );
    PUSHs( sv_2mortal( newSViv( index ) ) );

unsigned int
wxConfigBase::GetNumberOfEntries( recursive = FALSE )
    bool recursive

unsigned int
wxConfigBase::GetNumberOfGroups( recursive = FALSE )
    bool recursive

wxString
wxConfigBase::GetPath()

wxString
wxConfigBase::GetVendorName()

bool
wxConfigBase::HasEntry( name )
    wxString name

bool
wxConfigBase::HasGroup( name )
    wxString name

bool
wxConfigBase::IsExpandingEnvVars()

bool
wxConfigBase::IsRecordingDefaults()

wxString
wxConfigBase::Read( key, def = wxEmptyString )
    wxString key
    wxString def
  CODE:
    THIS->Read( key, &RETVAL, def );
  OUTPUT:
    RETVAL

long
wxConfigBase::ReadInt( key, def = 0 )
    wxString key
    long def
  CODE:
    THIS->Read( key, &RETVAL, def );
  OUTPUT:
    RETVAL

double
wxConfigBase::ReadFloat( key, def = 0.0 )
    wxString key
    double def
  CODE:
    THIS->Read( key, &RETVAL, def );
  OUTPUT:
    RETVAL

bool
wxConfigBase::ReadBool( key, def = FALSE )
    wxString key
    bool def
  CODE:
    THIS->Read( key, &RETVAL, def );
  OUTPUT:
    RETVAL

bool
wxConfigBase::RenameEntry( oldName, newName )
     wxString oldName
     wxString newName

bool
wxConfigBase::RenameGroup( oldName, newName )
     wxString oldName
     wxString newName

void
Set( config )
    wxConfigBase* config
  CODE:
    wxConfigBase::Set( config );

void
wxConfigBase::SetExpandEnvVars( doIt = TRUE )
    bool doIt

void
wxConfigBase::SetPath( path )
    wxString path

void
wxConfigBase::SetRecordDefaults( doIt = TRUE )
    bool doIt

void
wxConfigBase::Write( key, value )
    wxString key
    wxString value
  CODE:
    THIS->Write( key, value );

void
wxConfigBase::WriteInt( key, value )
    wxString key
    long value
  CODE:
    THIS->Write( key, value );

void
wxConfigBase::WriteFloat( key, value )
    wxString key
    double value
  CODE:
    THIS->Write( key, value );

void
wxConfigBase::WriteBool( key, value )
    wxString key
    bool value
  CODE:
    THIS->Write( key, value );

MODULE=Wx PACKAGE=Wx::RegConfig

#if defined(__WXMSW__)

#include <wx/msw/regconf.h>

wxConfigBase*
wxRegConfig::new( appName = wxEmptyString, vendorName = wxEmptyString, localFilename = wxEmptyString, globalFilename = wxEmptyString, style = 0 )
    wxString appName
    wxString vendorName
    wxString localFilename
    wxString globalFilename
    long style

#endif

MODULE=Wx PACKAGE=Wx::FileConfig

#include <wx/fileconf.h>

wxConfigBase*
wxFileConfig::new( appName = wxEmptyString, vendorName = wxEmptyString, localFilename = wxEmptyString, globalFilename = wxEmptyString, style = 0 )
    wxString appName
    wxString vendorName
    wxString localFilename
    wxString globalFilename
    long style


