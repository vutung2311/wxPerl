#############################################################################
## Name:        ext/docview/XS/DocManager.xs
## Purpose:     XS for wxDocument ( Document / View Framework )
## Author:      Simon Flack
## Modified by:
## Created:     11/09/2002
## RCS-ID:      $Id: DocManager.xs,v 1.8 2004/02/28 22:59:07 mbarbon Exp $
## Copyright:   (c) 2002-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################


MODULE=Wx PACKAGE=Wx::DocManager

Wx_DocManager*
Wx_DocManager::new( flags = wxDEFAULT_DOCMAN_FLAGS, initialize = TRUE )
    long flags
    bool initialize
  CODE:
    RETVAL=new wxPliDocManager(CLASS, flags, initialize);
  OUTPUT:
    RETVAL

bool
Wx_DocManager::Clear( force )
    bool force

bool
Wx_DocManager::Initialize()

Wx_FileHistory*
Wx_DocManager::OnCreateFileHistory()

Wx_FileHistory*
Wx_DocManager::GetFileHistory()

void
Wx_DocManager::SetMaxDocsOpen(n)
    int n

int
Wx_DocManager::GetMaxDocsOpen()

SV*
Wx_DocManager::GetDocuments()
  CODE:
    AV* arrDocs = wxPli_objlist_2_av( aTHX_ THIS->GetDocuments() );
    RETVAL = newRV_noinc( (SV*)arrDocs  );
  OUTPUT: RETVAL

void
Wx_DocManager::GetTemplates()
  PPCODE:
    wxNode* tmplnode;
    const wxList& tmpllist = THIS->GetTemplates();

    EXTEND( SP, tmpllist.GetCount() );

    for( tmplnode = tmpllist.GetFirst(); tmplnode;
         tmplnode = tmplnode->GetNext() )
    {
       SV* pltmpl
           = wxPli_object_2_sv( aTHX_ sv_newmortal(), tmplnode->GetData() ); 
       PUSHs( pltmpl );
    } 

wxString
Wx_DocManager::GetLastDirectory()

void
Wx_DocManager::SetLastDirectory( dir )
    wxString dir

void
Wx_DocManager::OnFileClose( event )
    Wx_CommandEvent* event
  CODE:
    THIS->OnFileClose( *event );

void
Wx_DocManager::OnFileCloseAll( event )
    Wx_CommandEvent* event
  CODE:
    THIS->OnFileCloseAll( *event );

void
Wx_DocManager::OnFileNew( event )
    Wx_CommandEvent* event
  CODE:
    THIS->OnFileNew( *event );

void
Wx_DocManager::OnFileOpen( event )
    Wx_CommandEvent* event
  CODE:
    THIS->OnFileOpen( *event );

void
Wx_DocManager::OnFileRevert( event )
    Wx_CommandEvent* event
  CODE:
    THIS->OnFileRevert( *event );

void
Wx_DocManager::OnFileSave( event )
    Wx_CommandEvent* event
  CODE:
    THIS->OnFileSave( *event );

void
Wx_DocManager::OnFileSaveAs( event )
    Wx_CommandEvent* event
  CODE:
    THIS->OnFileSaveAs( *event );

void
Wx_DocManager::OnPrint( event )
    Wx_CommandEvent* event
  CODE:
    THIS->OnPrint( *event );

void
Wx_DocManager::OnPrintSetup( event )
    Wx_CommandEvent* event
  CODE:
    THIS->OnPrintSetup( *event );

void
Wx_DocManager::OnPreview( event )
    Wx_CommandEvent* event
  CODE:
    THIS->OnPreview( *event );

void
Wx_DocManager::OnUndo( event )
    Wx_CommandEvent* event
  CODE:
    THIS->OnUndo( *event );

void
Wx_DocManager::OnRedo( event )
    Wx_CommandEvent* event
  CODE:
    THIS->OnRedo( *event );

void
Wx_DocManager::OnUpdateFileOpen( event )
    Wx_UpdateUIEvent* event
  CODE:
    THIS->OnUpdateFileOpen( *event );

void
Wx_DocManager::OnUpdateFileClose( event )
    Wx_UpdateUIEvent* event
  CODE:
    THIS->OnUpdateFileClose( *event );

void
Wx_DocManager::OnUpdateFileRevert( event )
    Wx_UpdateUIEvent* event
  CODE:
    THIS->OnUpdateFileRevert( *event );

void
Wx_DocManager::OnUpdateFileNew( event )
    Wx_UpdateUIEvent* event
  CODE:
    THIS->OnUpdateFileNew( *event );

void
Wx_DocManager::OnUpdateFileSave( event )
    Wx_UpdateUIEvent* event
  CODE:
    THIS->OnUpdateFileSave( *event );

void
Wx_DocManager::OnUpdateFileSaveAs( event )
    Wx_UpdateUIEvent* event
  CODE:
    THIS->OnUpdateFileSaveAs( *event );

void
Wx_DocManager::OnUpdateUndo( event )
    Wx_UpdateUIEvent* event
  CODE:
    THIS->OnUpdateUndo( *event );

void
Wx_DocManager::OnUpdateRedo( event )
    Wx_UpdateUIEvent* event
  CODE:
    THIS->OnUpdateRedo( *event );

void
Wx_DocManager::OnUpdatePrint( event )
    Wx_UpdateUIEvent* event
  CODE:
    THIS->OnUpdatePrint( *event );

void
Wx_DocManager::OnUpdatePrintSetup( event )
    Wx_UpdateUIEvent* event
  CODE:
    THIS->OnUpdatePrintSetup( *event );

void
Wx_DocManager::OnUpdatePreview( event )
    Wx_UpdateUIEvent* event
  CODE:
    THIS->OnUpdatePreview( *event );

Wx_View *
Wx_DocManager::GetCurrentView()

Wx_Document *
Wx_DocManager::CreateDocument( path, flags = 0 )
    wxString path
    long flags


Wx_View *
Wx_DocManager::CreateView( doc, flags = 0 )
    Wx_Document* doc
    long flags

void
Wx_DocManager::DeleteTemplate( temp, flags = 0 )
    Wx_DocTemplate* temp
    long flags

bool
Wx_DocManager::FlushDoc( doc )
    Wx_Document* doc

Wx_Document *
Wx_DocManager::GetCurrentDocument()

bool
Wx_DocManager::MakeDefaultName( name )
    wxString name

wxString
Wx_DocManager::MakeFrameTitle( doc )
    Wx_Document* doc

Wx_DocTemplate *
Wx_DocManager::MatchTemplate( path )
    wxString path

void
Wx_DocManager::AddFileToHistory( file )
    wxString file

void
Wx_DocManager::RemoveFileFromHistory( i )
    int i


wxString
Wx_DocManager::GetHistoryFile( i )
    int i

void
Wx_DocManager::FileHistoryUseMenu( menu )
    wxMenu* menu

void
Wx_DocManager::FileHistoryRemoveMenu( menu )
    wxMenu* menu


#if wxUSE_CONFIG

## Need wxConfigBase& in typemap

##void
##Wx_DocManager::FileHistoryLoad( config )
##    Wx_ConfigBase config
##  CODE:
##    THIS->FileHistoryLoad( config )
##
##void
##Wx_DocManager::FileHistorySave( config )
##    Wx_ConfigBase config
##  CODE:
##    THIS->FileHistoryLoad( config )

#endif

void
Wx_DocManager::FileHistoryAddFilesToMenu( ... )
  CASE: items == 1
    CODE:
      THIS->FileHistoryAddFilesToMenu();
  CASE: items == 2
    INPUT:
      wxMenu* menu = NO_INIT
    CODE:
      THIS->FileHistoryAddFilesToMenu( menu );
  CASE:
    CODE:
      croak( "Usage: Wx::FileHistory::AddfilesToMenu(THIS [, menu ] )" );

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

size_t
wxDocManager::GetHistoryFilesCount()

#else

int
Wx_DocManager::GetNoHistoryFiles()

#endif

Wx_DocTemplate *
Wx_DocManager::FindTemplateForPath( path )
    wxString path

Wx_DocTemplate *
Wx_DocManager::SelectDocumentPath( templates, noTemplates, path, flags, save = FALSE)
    AV* templates
    int noTemplates
    wxString path
    long flags
    bool save
  PREINIT:
    int tmpl_n;
    int i;
    wxDocTemplate **pltemplates;
    Wx_DocTemplate *thistemplate;
  CODE:
    tmpl_n = av_len(templates) + 1;
    pltemplates = new wxDocTemplate *[ tmpl_n ];
    for(i = 0; i < tmpl_n; i++)
    {
      SV** pltemplate = av_fetch( (AV*) templates, i, 0 );
      Wx_DocTemplate* thistemplate = (Wx_DocTemplate *)
                      wxPli_sv_2_object( aTHX_ *pltemplate, "Wx::DocTemplate" );
      pltemplates[i] = thistemplate;
    }
    RETVAL = THIS->SelectDocumentPath(pltemplates, noTemplates, path, flags, save);
    delete[] pltemplates;
  OUTPUT:
    RETVAL

Wx_DocTemplate *
Wx_DocManager::SelectDocumentType( templates, noTemplates, sort = FALSE)
    AV* templates
    int noTemplates
    bool sort
  PREINIT:
    int tmpl_n;
    int i;
    wxDocTemplate **pltemplates;
    Wx_DocTemplate *thistemplate;
  CODE:
    tmpl_n = av_len(templates) + 1;
    pltemplates = new wxDocTemplate *[ tmpl_n ];
    for(i = 0; i < tmpl_n; i++)
    {
      SV** pltemplate = av_fetch( (AV*) templates, i, 0 );
      Wx_DocTemplate* thistemplate = (Wx_DocTemplate *)
                      wxPli_sv_2_object( aTHX_ *pltemplate, "Wx::DocTemplate" );
      pltemplates[i] = thistemplate;
    }
    RETVAL = THIS->SelectDocumentType(pltemplates, noTemplates, sort);
    delete[] pltemplates;
  OUTPUT:
    RETVAL



Wx_DocTemplate *
Wx_DocManager::SelectViewType( templates, noTemplates, sort = FALSE)
    AV* templates
    int noTemplates
    bool sort
  PREINIT:
    int tmpl_n;
    int i;
    wxDocTemplate **pltemplates;
    Wx_DocTemplate *thistemplate;
  CODE:
    tmpl_n = av_len(templates) + 1;
    pltemplates = new wxDocTemplate *[ tmpl_n ];
    for(i = 0; i < tmpl_n; i++)
    {
      SV** pltemplate = av_fetch( (AV*) templates, i, 0 );
      Wx_DocTemplate* thistemplate = (Wx_DocTemplate *)
                      wxPli_sv_2_object( aTHX_ *pltemplate, "Wx::DocTemplate" );
      pltemplates[i] = thistemplate;
    }
    RETVAL = THIS->SelectViewType(pltemplates, noTemplates, sort);
    delete[] pltemplates;
  OUTPUT:
    RETVAL

void
Wx_DocManager::AssociateTemplate( temp )
    Wx_DocTemplate* temp

void
Wx_DocManager::DisassociateTemplate( temp )
    Wx_DocTemplate* temp

void
Wx_DocManager::AddDocument( doc )
    Wx_Document* doc

void
Wx_DocManager::RemoveDocument( doc )
    Wx_Document* doc

bool
Wx_DocManager::CloseDocuments( force = TRUE )
    bool force

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

void
wxDocManager::ActivateView( view, activate = TRUE )
    wxView* view
    bool activate

#else

void
Wx_DocManager::ActivateView( view, activate = TRUE, deleting = FALSE )
    Wx_View* view
    bool activate
    bool deleting

#endif