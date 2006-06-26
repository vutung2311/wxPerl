/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/typedef.h
// Purpose:     forward declare and typdef wxClass to Wx_Class
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: typedef.h,v 1.51 2006/06/26 21:27:37 mbarbon Exp $
// Copyright:   (c) 2000-2004 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_TYPEDEF_H
#define _WXPERL_TYPEDEF_H

#define FD_TD( name ) \
  class wx##name; \
  typedef wx##name Wx_##name;

#define FD_TDS( name ) \
  struct wx##name; \
  typedef wx##name Wx_##name;

#define FD_TD_NAME( name, cls ) \
  class wx##cls; \
  typedef wx##cls Wx_##name;

// event classes
FD_TD( Event );
FD_TD( ActivateEvent );
FD_TD( CloseEvent );
FD_TD( CommandEvent );
FD_TD( EraseEvent );
FD_TD( FindDialogEvent );
FD_TD( FocusEvent );
FD_TD( HelpEvent );
FD_TD( IconizeEvent );
FD_TD( IdleEvent );
FD_TD( InitDialogEvent );
FD_TD( JoystickEvent );
FD_TD( KeyEvent );
FD_TD( ListEvent );
FD_TD( MenuEvent );
FD_TD( MouseEvent );
FD_TD( MoveEvent );
FD_TD( NotifyEvent );
FD_TD( PaintEvent );
FD_TD( ScrollWinEvent );
FD_TD( SizeEvent );
FD_TD( SplitterEvent );
FD_TD( SysColourChangedEvent );
FD_TD( TimerEvent );
FD_TD( UpdateUIEvent );
FD_TD( ProcessEvent );
FD_TD( WizardEvent );

FD_TD( PlEvent );
FD_TD( PlCommandEvent );
FD_TD( PlThreadEvent );

// other classes

class wxPlValidator;  typedef wxPlValidator  Wx_PlValidator;
class wxPlSizer;      typedef wxPlSizer      Wx_PlSizer;
class wxPliUserDataO; typedef wxPliUserDataO   Wx_UserDataO;
class wxPliUserDataCD;typedef wxPliUserDataCD  Wx_UserDataCD;

FD_TD( AcceleratorEntry );
FD_TD( AcceleratorTable );
FD_TD( App );
FD_TD( Bitmap );
FD_TD( BitmapHandler );
FD_TD( BoxSizer );
FD_TD( Brush );
FD_TD( BusyCursor );
FD_TD( BusyInfo );
FD_TD( Caret );
FD_TD( CaretSuspend );
FD_TD( ClassInfo );
FD_TD( ClientDC );
FD_TD( Colour );
FD_TD( ColourData );

#if defined( __WXMOTIF__ ) || defined( __WXGTK__ )
FD_TD_NAME( ColourDialog, GenericColourDialog );
#else
FD_TD( ColourDialog );
#endif

FD_TD( Config );
FD_TD( ConfigBase );
FD_TD( Control );
FD_TD( Cursor );
FD_TD( DC );
FD_TD( Dialog );
#if defined( __WXMSW__ ) || defined( __WXMAC__ )
FD_TD( DirDialog );
#else
FD_TD_NAME( DirDialog, GenericDirDialog );
#endif
FD_TD( DrawObject );
FD_TD( DropTarget );
FD_TD( FileConfig );
FD_TD( FileDialog );
FD_TD( FindReplaceData );
FD_TD( FindReplaceDialog );
FD_TD( FlexGridSizer );
FD_TD( Font );
FD_TD( FontData );

#if defined( __WXMOTIF__ ) || defined( __WXMAC__ ) || defined(__WXUNIVERSAL__)
FD_TD_NAME( FontDialog, GenericFontDialog );
#else
FD_TD( FontDialog );
#endif

FD_TD( FontEnumerator )
FD_TD( FontMapper )
FD_TD( Frame );
FD_TD( GridSizer );
FD_TD( Icon );
FD_TD( IndividualLayoutConstraint );
FD_TDS( LanguageInfo )
FD_TD( LayoutConstraints );
FD_TD( ListCtrl );
FD_TD( ListItem );
FD_TD( ListItemAttr );
FD_TD( Locale );
FD_TD( Log );
FD_TD( LogGui );
FD_TD( LogNull );
FD_TD( LogTextCtrl );
FD_TD( LogWindow );
FD_TD( Mask );
FD_TD( MemoryDC );
FD_TD( Menu );
FD_TD( MenuBar );
FD_TD( MenuItem );

#if defined( __WXGTK__ )
FD_TD_NAME( MessageDialog, GenericMessageDialog );
#else
FD_TD( MessageDialog );
#endif

FD_TD( MultiChoiceDialog );
FD_TD( NotebookSizer );
FD_TD( Object );
FD_TD( PaintDC );
FD_TD( Palette );
FD_TD( Panel );
FD_TD( Pen );
FD_TD( Point );
FD_TD( Process );
FD_TD( ProgressDialog );
FD_TD( Rect );
FD_TD( RegConfig );
FD_TD( Region );
FD_TD( ScreenDC );
FD_TD( ScrolledWindow );
FD_TD( SingleChoiceDialog );
FD_TD( SingleInstanceChecker );
FD_TD( Size );
FD_TD( Sizer );
FD_TD( SizerItem );
FD_TD( SplashScreen );
FD_TD( SplitterWindow );
FD_TD( StaticBoxSizer );
FD_TD( StaticCtrl );
FD_TD( StaticLine );
FD_TD( StopWatch );
FD_TD( TaskBarIcon );
FD_TD( TextAttr );
FD_TD( TextCtrl );
FD_TD( TextEntryDialog );
FD_TD( Timer );
FD_TD( TipProvider );
FD_TD( ToolBar );
FD_TD( ToolBarBase );
FD_TD( ToolBarToolBase );
FD_TD( ToolTip );
FD_TD( Validator );
FD_TD( Window );
FD_TD( WindowDC );
FD_TD( WindowDisabler );
FD_TD( Wizard );
FD_TD( WizardPage );
FD_TD( WizardPageSimple );

FD_TD( StreamBase );
FD_TD( InputStream );
FD_TD( OutputStream );

#undef FD_TD
#undef TD_TDS
#undef FD_TD_NAME

#endif // _WXPERL_TYPEDEF_H
