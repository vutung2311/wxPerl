/////////////////////////////////////////////////////////////////////////////
// Name:        Constant.xs
// Purpose:     defines the constant() and SetConstants() functions
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool

#include <wx/defs.h>

#include <wx/filedlg.h>
#include <wx/colordlg.h>
#include <wx/textdlg.h>
#include <wx/choicdlg.h>
#include <wx/msgdlg.h>
#include <wx/gdicmn.h>
#include <wx/bitmap.h>
#include <wx/intl.h>
#include <wx/icon.h>
#include <wx/imaglist.h>
#include <wx/notebook.h>
#include <wx/dialup.h>
#include <wx/process.h>
#include <wx/pen.h>
#include <wx/brush.h>
#include <wx/layout.h>
#include <wx/splitter.h>
#include <wx/sashwin.h>
#include <wx/textctrl.h>
#include <wx/listctrl.h>
#include <wx/settings.h>
#include <wx/treectrl.h>
#include <stdarg.h>

#undef _

#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#undef bool
#undef Move
#undef Copy

#if __VISUALC__
#pragma warning (disable: 4800 )
#endif

#include "cpp/compat.h"

static double constant( const char *name, int arg ) 
{
  errno = 0;
  char fl = name[0];

  if( tolower( name[0] ) == 'w' && tolower( name[1] ) == 'x' )
    fl = name[2];

#define r( n ) \
if( strEQ( name, #n ) ) \
  return n;

  switch( fl ) {
  case 'A':
    r( wxALIGN_LEFT );                  // sizer statictext
    r( wxALIGN_CENTRE );                // sizer statictext
    r( wxALIGN_RIGHT );                 // sizer statictext
    r( wxALIGN_TOP );                   // sizer
    r( wxALIGN_BOTTOM );                // sizer
    r( wxALIGN_CENTER_VERTICAL );       // sizer
    r( wxALIGN_CENTER_HORIZONTAL );     // sizer
    r( wxALL );                         // sizer

    r( wxACCEL_ALT );
    r( wxACCEL_CTRL );
    r( wxACCEL_NORMAL );
    r( wxACCEL_SHIFT );

    r( wxAND );                         // dc
    r( wxAND_INVERT );                  // dc
    r( wxAND_REVERSE );                 // dc

    r( wxAbove );                       // layout constraints
    r( wxAbsolute );                    // layout constraints
    r( wxAsIs );                        // layout constraints
    break;
  case 'B':
    r( wxBITMAP_TYPE_BMP );             // bitmap icon image
    r( wxBITMAP_TYPE_BMP_RESOURCE );    // bitmap icon image
    r( wxBITMAP_TYPE_CUR );             // bitmap icon image
    r( wxBITMAP_TYPE_CUR_RESOURCE );    // bitmap icon image
    r( wxBITMAP_TYPE_ICO );             // bitmap icon image
    r( wxBITMAP_TYPE_ICO_RESOURCE );    // bitmap icon image
    r( wxBITMAP_TYPE_GIF );             // bitmap icon image
    r( wxBITMAP_TYPE_XBM );             // bitmap icon image
    r( wxBITMAP_TYPE_XPM );             // bitmap icon image
    r( wxBITMAP_TYPE_JPEG );            // bitmap icon image
    r( wxBITMAP_TYPE_PNG );             // bitmap icon image
    r( wxBITMAP_TYPE_PNM );             // bitmap icon image
    r( wxBITMAP_TYPE_PCX );             // bitmap icon image
    r( wxBITMAP_TYPE_ANY );             // bitmap icon image
    r( wxBITMAP_TYPE_TIF );             // bitmap icon image

    r( wxBOLD );                        // font
    r( wxBOTH );                        // window dialog frame
    r( wxBOTTOM );                      // sizer
    r( wxBU_TOP );                      // button
    r( wxBU_LEFT );                     // button
    r( wxBU_BOTTOM );                   // button
    r( wxBU_AUTODRAW );                 // button
    r( wxBU_RIGHT );                    // button

    r( wxBDIAGONAL_HATCH );             // brush pen

    r( wxBottom );                      // layout constraints 
    r( wxBelow );                       // layout constraints
    break;
  case 'C':
    r( wxCANCEL );                      // dialog
    r( wxCAPTION );                     // frame dialog

    r( wxCAP_ROUND );                   // pen
    r( wxCAP_PROJECTING );              // pen
    r( wxCAP_BUTT );                    // pen
    r( wxCAP_ROUND );                   // pen

    r( wxCB_SIMPLE );                   // combobox
    r( wxCB_DROPDOWN );                 // combobox
    r( wxCB_READONLY );                 // combobox
    r( wxCB_SORT );                     // combobox
    r( wxCENTRE );                      // dialog sizer
    r( wxCENTER );                      // dialog sizer
    r( wxCLIP_CHILDREN );               // window
    r( wxCHOICEDLG_STYLE );
#if WXPERL_W_VERSION_GE( 2, 3 )
    r( wxCHANGE_DIR );
    r( wxCLIP_SIBLINGS );               // window
#endif

    r( wxCLEAR );                       // dc
    r( wxCOPY );                        // dc

    r( wxCURSOR_ARROW );                // cursor
    r( wxCURSOR_BULLSEYE );             // cursor
    r( wxCURSOR_CHAR );                 // cursor
    r( wxCURSOR_CROSS );                // cursor
    r( wxCURSOR_HAND );                 // cursor
    r( wxCURSOR_IBEAM );                // cursor
    r( wxCURSOR_LEFT_BUTTON );          // cursor
    r( wxCURSOR_MAGNIFIER );            // cursor
    r( wxCURSOR_MIDDLE_BUTTON );        // cursor
    r( wxCURSOR_NO_ENTRY );             // cursor
    r( wxCURSOR_PAINT_BRUSH );          // cursor
    r( wxCURSOR_PENCIL );               // cursor
    r( wxCURSOR_POINT_LEFT );           // cursor
    r( wxCURSOR_POINT_RIGHT );          // cursor
    r( wxCURSOR_QUESTION_ARROW );       // cursor
    r( wxCURSOR_RIGHT_BUTTON );         // cursor
    r( wxCURSOR_SIZENESW );             // cursor
    r( wxCURSOR_SIZENS );               // cursor
    r( wxCURSOR_SIZENWSE );             // cursor
    r( wxCURSOR_SIZEWE );               // cursor
    r( wxCURSOR_SIZING );               // cursor
    r( wxCURSOR_SPRAYCAN );             // cursor
    r( wxCURSOR_WAIT );                 // cursor
    r( wxCURSOR_WATCH );                // cursor

    r( wxCROSSDIAG_HATCH );             // brush pen
    r( wxCROSS_HATCH );                 // brush pen

    r( wxCentreX );                     // layout constraints
    r( wxCentreY );                     // layout constraints
    break;
  case 'D':
    r( wxDECORATIVE );                  // font
    r( wxDEFAULT );                     // font
    r( wxDEFAULT_DIALOG_STYLE );        // dialog
    r( wxDEFAULT_FRAME_STYLE );         // frame
    r( wxDIALOG_MODAL );                // dialog
    r( wxDOUBLE_BORDER );               // window
#if WXPERL_W_VERSION_GE( 2, 3 )
    r( wxDIALOG_NO_PARENT );            // dialog
    r( wxDIALOG_EX_CONTEXTHELP );       // dialog
#endif

    r( wxDOT );                         // pen
    r( wxDOT_DASH );                    // pen

    break;
  case 'E':
    r( wxEQUIV );                       // dc

    r( wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED );
    r( wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING );
    r( wxEVT_COMMAND_BUTTON_CLICKED );
    r( wxEVT_COMMAND_CHECKBOX_CLICKED );
    r( wxEVT_COMMAND_CHOICE_SELECTED );
    r( wxEVT_COMMAND_LISTBOX_SELECTED );
    r( wxEVT_COMMAND_LISTBOX_DOUBLECLICKED );
    r( wxEVT_COMMAND_CHECKLISTBOX_TOGGLED );
    r( wxEVT_COMMAND_TEXT_UPDATED );
    r( wxEVT_COMMAND_TEXT_ENTER );
    r( wxEVT_COMMAND_MENU_SELECTED );
    r( wxEVT_COMMAND_TOOL_CLICKED );
    r( wxEVT_COMMAND_SLIDER_UPDATED );
    r( wxEVT_COMMAND_RADIOBOX_SELECTED );
    r( wxEVT_COMMAND_RADIOBUTTON_SELECTED );
    r( wxEVT_COMMAND_SCROLLBAR_UPDATED );
    r( wxEVT_COMMAND_VLBOX_SELECTED );
    r( wxEVT_COMMAND_COMBOBOX_SELECTED );
    r( wxEVT_COMMAND_TOOL_RCLICKED );
    r( wxEVT_COMMAND_TOOL_ENTER );
    r( wxEVT_COMMAND_SPINCTRL_UPDATED );
    r( wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING );
    r( wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED );
    r( wxEVT_COMMAND_SPLITTER_UNSPLIT );
    r( wxEVT_COMMAND_SPLITTER_DOUBLECLICKED );

    r( wxEVT_COMMAND_TREE_BEGIN_DRAG );
    r( wxEVT_COMMAND_TREE_BEGIN_RDRAG );
    r( wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT );
    r( wxEVT_COMMAND_TREE_END_LABEL_EDIT );
    r( wxEVT_COMMAND_TREE_DELETE_ITEM );
    r( wxEVT_COMMAND_TREE_GET_INFO );
    r( wxEVT_COMMAND_TREE_SET_INFO );
    r( wxEVT_COMMAND_TREE_ITEM_EXPANDED );
    r( wxEVT_COMMAND_TREE_ITEM_EXPANDING );
    r( wxEVT_COMMAND_TREE_ITEM_COLLAPSED );
    r( wxEVT_COMMAND_TREE_ITEM_COLLAPSING );
    r( wxEVT_COMMAND_TREE_SEL_CHANGED );
    r( wxEVT_COMMAND_TREE_SEL_CHANGING );
    r( wxEVT_COMMAND_TREE_KEY_DOWN );
    r( wxEVT_COMMAND_TREE_ITEM_ACTIVATED );
    r( wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK );
    r( wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK );
    r( wxEVT_COMMAND_TREE_END_DRAG );

    r( wxEVT_TIMER );

    r( wxEVT_LEFT_DOWN );
    r( wxEVT_LEFT_UP );
    r( wxEVT_MIDDLE_DOWN );
    r( wxEVT_MIDDLE_UP );
    r( wxEVT_RIGHT_DOWN );
    r( wxEVT_RIGHT_UP );
    r( wxEVT_MOTION );
    r( wxEVT_ENTER_WINDOW );
    r( wxEVT_LEAVE_WINDOW );
    r( wxEVT_LEFT_DCLICK );
    r( wxEVT_MIDDLE_DCLICK );
    r( wxEVT_RIGHT_DCLICK );
    r( wxEVT_SET_FOCUS );
    r( wxEVT_KILL_FOCUS );

    r( wxEVT_SASH_DRAGGED );

    r( wxEVT_NC_LEFT_DOWN );
    r( wxEVT_NC_LEFT_UP );
    r( wxEVT_NC_MIDDLE_DOWN );
    r( wxEVT_NC_MIDDLE_UP );
    r( wxEVT_NC_RIGHT_DOWN );
    r( wxEVT_NC_RIGHT_UP );
    r( wxEVT_NC_MOTION );
    r( wxEVT_NC_ENTER_WINDOW );
    r( wxEVT_NC_LEAVE_WINDOW );
    r( wxEVT_NC_LEFT_DCLICK );
    r( wxEVT_NC_MIDDLE_DCLICK );
    r( wxEVT_NC_RIGHT_DCLICK );

    r( wxEVT_CHAR );
    r( wxEVT_CHAR_HOOK );
    r( wxEVT_NAVIGATION_KEY );
    r( wxEVT_KEY_DOWN );
    r( wxEVT_KEY_UP );

    r( wxEVT_SET_CURSOR );

    r( wxEVT_SCROLL_TOP );
    r( wxEVT_SCROLL_BOTTOM );
    r( wxEVT_SCROLL_LINEUP );
    r( wxEVT_SCROLL_LINEDOWN );
    r( wxEVT_SCROLL_PAGEUP );
    r( wxEVT_SCROLL_PAGEDOWN );
    r( wxEVT_SCROLL_THUMBTRACK );
    r( wxEVT_SCROLL_THUMBRELEASE );

    r( wxEVT_SCROLLWIN_TOP );
    r( wxEVT_SCROLLWIN_BOTTOM );
    r( wxEVT_SCROLLWIN_LINEUP );
    r( wxEVT_SCROLLWIN_LINEDOWN );
    r( wxEVT_SCROLLWIN_PAGEUP );
    r( wxEVT_SCROLLWIN_PAGEDOWN );
    r( wxEVT_SCROLLWIN_THUMBTRACK );
    r( wxEVT_SCROLLWIN_THUMBRELEASE );

    r( wxEVT_SIZE );
    r( wxEVT_MOVE );
    r( wxEVT_CLOSE_WINDOW );
    r( wxEVT_END_SESSION );
    r( wxEVT_QUERY_END_SESSION );
    r( wxEVT_ACTIVATE_APP );
    r( wxEVT_POWER );
    r( wxEVT_ACTIVATE );
    r( wxEVT_CREATE );
    r( wxEVT_DESTROY );
    r( wxEVT_SHOW );
    r( wxEVT_ICONIZE );
    r( wxEVT_MAXIMIZE );
    r( wxEVT_MOUSE_CAPTURE_CHANGED );
    r( wxEVT_PAINT );
    r( wxEVT_ERASE_BACKGROUND );
    r( wxEVT_NC_PAINT );
    r( wxEVT_PAINT_ICON );
    r( wxEVT_MENU_CHAR );
    r( wxEVT_MENU_INIT );
    r( wxEVT_MENU_HIGHLIGHT );
    r( wxEVT_POPUP_MENU_INIT );
    r( wxEVT_CONTEXT_MENU );
    r( wxEVT_SYS_COLOUR_CHANGED );
    r( wxEVT_SETTING_CHANGED );
    r( wxEVT_QUERY_NEW_PALETTE );
    r( wxEVT_PALETTE_CHANGED );
    r( wxEVT_JOY_BUTTON_DOWN );
    r( wxEVT_JOY_BUTTON_UP );
    r( wxEVT_JOY_MOVE );
    r( wxEVT_JOY_ZMOVE );
    r( wxEVT_DROP_FILES );
    r( wxEVT_DRAW_ITEM );
    r( wxEVT_MEASURE_ITEM );
    r( wxEVT_COMPARE_ITEM );
    r( wxEVT_INIT_DIALOG );
    r( wxEVT_IDLE );
    r( wxEVT_UPDATE_UI );

    r( wxEVT_END_PROCESS );

    r( wxEVT_DIALUP_CONNECTED );
    r( wxEVT_DIALUP_DISCONNECTED );

    r( wxEVT_COMMAND_LEFT_CLICK );
    r( wxEVT_COMMAND_LEFT_DCLICK );
    r( wxEVT_COMMAND_RIGHT_CLICK );
    r( wxEVT_COMMAND_RIGHT_DCLICK );
    r( wxEVT_COMMAND_SET_FOCUS );
    r( wxEVT_COMMAND_KILL_FOCUS );
    r( wxEVT_COMMAND_ENTER );

    r( wxEVT_COMMAND_LIST_BEGIN_DRAG );
    r( wxEVT_COMMAND_LIST_BEGIN_RDRAG );
    r( wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT );
    r( wxEVT_COMMAND_LIST_END_LABEL_EDIT );
    r( wxEVT_COMMAND_LIST_DELETE_ITEM );
    r( wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS );
    r( wxEVT_COMMAND_LIST_SET_INFO );
    r( wxEVT_COMMAND_LIST_GET_INFO );
    r( wxEVT_COMMAND_LIST_ITEM_SELECTED );
    r( wxEVT_COMMAND_LIST_ITEM_DESELECTED );
    r( wxEVT_COMMAND_LIST_KEY_DOWN );
    r( wxEVT_COMMAND_LIST_INSERT_ITEM );
    r( wxEVT_COMMAND_LIST_COL_CLICK );
    r( wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK );
    r( wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK );
    r( wxEVT_COMMAND_LIST_ITEM_ACTIVATED );

#if WXPERL_W_VERSION_GE( 2, 3 )
    r( wxEVT_HELP );
    r( wxEVT_DETAILED_HELP );
#endif

    r( wxEXPAND );                      // sizer
    break;
  case 'F':
    r( wxFDIAGONAL_HATCH );             // brush pen

    r( wxFILE_MUST_EXIST );
    r( wxFLOOD_SURFACE );               // dc
    r( wxFLOOD_BORDER );                // dc
    r( wxFONTENCODING_DEFAULT );        // font
    r( wxFONTENCODING_SYSTEM );         // font
    r( wxFRAME_FLOAT_ON_PARENT );       // frame
    r( wxFRAME_TOOL_WINDOW );           // frame
#if WXPERL_W_VERSION_GE( 2, 3 )
    r( wxFRAME_NO_TASKBAR );            // frame
    r( wxFRAME_TOOL_WINDOW );           // frame
    r( wxFRAME_EX_CONTEXTHELP );        // frame
#endif

    r( wxFONTENCODING_ISO8859_1 );      // font
    r( wxFONTENCODING_ISO8859_2 );      // font
    r( wxFONTENCODING_ISO8859_3 );      // font
    r( wxFONTENCODING_ISO8859_4 );      // font
    r( wxFONTENCODING_ISO8859_5 );      // font
    r( wxFONTENCODING_ISO8859_6 );      // font
    r( wxFONTENCODING_ISO8859_7 );      // font
    r( wxFONTENCODING_ISO8859_8 );      // font
    r( wxFONTENCODING_ISO8859_9 );      // font
    r( wxFONTENCODING_ISO8859_10 );     // font
    r( wxFONTENCODING_ISO8859_11 );     // font
    r( wxFONTENCODING_ISO8859_12 );     // font
    r( wxFONTENCODING_ISO8859_13 );     // font
    r( wxFONTENCODING_ISO8859_14 );     // font
    r( wxFONTENCODING_ISO8859_15 );     // font
    r( wxFONTENCODING_KOI8 );           // font
    r( wxFONTENCODING_CP1250 );         // font
    r( wxFONTENCODING_CP1251 );         // font
    r( wxFONTENCODING_CP1252 );         // font
    break;
  case 'G':
    r( wxGA_HORIZONTAL );               // gauge
    r( wxGA_VERTICAL );                 // gauge
    r( wxGA_PROGRESSBAR );              // gauge
    r( wxGA_SMOOTH );                   // gauge
    r( wxGROW );                        // sizer
    break;
  case 'H':
    r( wxHIDE_READONLY );               // filedialog
    r( wxHORIZONTAL );                  // toolbar sizer
    r( wxHORIZONTAL_HATCH );            // dc

    r( wxHSCROLL );                     // window textctrl

    r( wxHeight );                      // layout constraints
    break;
  case 'I':
    r( wxICONIZE );                     // frame
    r( wxICON_EXCLAMATION );            // icon
    r( wxICON_HAND );                   // icon
    r( wxICON_QUESTION );               // icon
    r( wxICON_INFORMATION );            // icon
    r( wxICON_WARNING );                // icon

    r( wxID_OPEN );                     // id
    r( wxID_CLOSE );                    // id
    r( wxID_NEW );                      // id
    r( wxID_SAVE );                     // id
    r( wxID_SAVEAS );                   // id
    r( wxID_REVERT );                   // id
    r( wxID_EXIT );                     // id
    r( wxID_UNDO );                     // id
    r( wxID_REDO );                     // id
    r( wxID_PRINT );                    // id
    r( wxID_PRINT_SETUP );              // id
    r( wxID_PREVIEW );                  // id
    r( wxID_ABOUT );                    // id
    r( wxID_HELP_CONTENTS );            // id
    r( wxID_HELP_COMMANDS );            // id
    r( wxID_HELP_PROCEDURES );          // id
    r( wxID_HELP_CONTEXT );             // id
    r( wxID_HELP );                     // id
    
    r( wxID_CUT );                      // id
    r( wxID_COPY );                     // id
    r( wxID_PASTE );                    // id
    r( wxID_CLEAR );                    // id
    r( wxID_FIND );                     // id
    r( wxID_DUPLICATE );                // id
    r( wxID_SELECTALL );                // id

    r( wxID_FILE1 );                    // id   
    r( wxID_FILE2 );                    // id   
    r( wxID_FILE3 );                    // id   
    r( wxID_FILE4 );                    // id   
    r( wxID_FILE5 );                    // id   
    r( wxID_FILE6 );                    // id   
    r( wxID_FILE7 );                    // id   
    r( wxID_FILE8 );                    // id   
    r( wxID_FILE9 );                    // id   

    r( wxID_OK );                       // id
    r( wxID_CANCEL );                   // id
    r( wxID_APPLY );                    // id
    r( wxID_YES );                      // id
    r( wxID_NO );                       // id
    r( wxID_STATIC );                   // id

#if WXPERL_W_VERSION_GE( 2, 3 )
    r( wxID_CONTEXT_HELP );             // id
    r( wxID_YESTOALL );                 // id
    r( wxID_NOTOALL );                  // id
    r( wxID_ABORT );                    // id
    r( wxID_RETRY );                    // id
    r( wxID_IGNORE );                   // id
#endif

    r( wxIMAGELIST_DRAW_NORMAL );       // imagelist
    r( wxIMAGELIST_DRAW_TRANSPARENT );  // imagelist
    r( wxIMAGELIST_DRAW_SELECTED );     // imagelist
    r( wxIMAGELIST_DRAW_FOCUSED );      // imagelist

    r( wxIMAGE_LIST_NORMAL );           // listctrl
    r( wxIMAGE_LIST_SMALL );            // listctrl
    r( wxIMAGE_LIST_STATE );            // listctrl

    r( wxINVERT );                      // dc

    r( wxITALIC );                      // font

    r( wxInRegion );                    // region
    break;
  case 'J':
    r( wxJOIN_BEVEL );                  // pen
    r( wxJOIN_ROUND );                  // pen
    r( wxJOIN_MITER );                  // pen

    r( wxJOYSTICK1 );                   // joystick
    r( wxJOYSTICK2 );                   // joystick
    r( wxJOY_BUTTON1 );                 // joystick
    r( wxJOY_BUTTON2 );                 // joystick
    r( wxJOY_BUTTON3 );                 // joystick
    r( wxJOY_BUTTON4 );                 // joystick
    r( wxJOY_BUTTON_ANY );              // joystick
    break;
  case 'K':
    if( strnEQ( name, "WXK_", 4 ) )
    {
        r( WXK_BACK );                  // keycode
        r( WXK_TAB );                   // keycode
        r( WXK_RETURN );                // keycode
        r( WXK_ESCAPE );                // keycode
        r( WXK_SPACE );                 // keycode
        r( WXK_DELETE );                // keycode
        r( WXK_START );                 // keycode
        r( WXK_LBUTTON );               // keycode
        r( WXK_RBUTTON );               // keycode
        r( WXK_CANCEL );                // keycode
        r( WXK_MBUTTON );               // keycode
        r( WXK_CLEAR );                 // keycode
        r( WXK_SHIFT );                 // keycode
        r( WXK_CONTROL );               // keycode
        r( WXK_MENU );                  // keycode
        r( WXK_PAUSE );                 // keycode
        r( WXK_CAPITAL );               // keycode
        r( WXK_PRIOR );                 // keycode
        r( WXK_NEXT );                  // keycode
        r( WXK_END );                   // keycode
        r( WXK_HOME );                  // keycode
        r( WXK_LEFT );                  // keycode
        r( WXK_UP );                    // keycode
        r( WXK_RIGHT );                 // keycode
        r( WXK_DOWN );                  // keycode
        r( WXK_SELECT );                // keycode
        r( WXK_PRINT );                 // keycode
        r( WXK_EXECUTE );               // keycode
        r( WXK_SNAPSHOT );              // keycode
        r( WXK_INSERT );                // keycode
        r( WXK_HELP );                  // keycode
        r( WXK_NUMPAD0 );               // keycode
        r( WXK_NUMPAD1 );               // keycode
        r( WXK_NUMPAD2 );               // keycode
        r( WXK_NUMPAD3 );               // keycode
        r( WXK_NUMPAD4 );               // keycode
        r( WXK_NUMPAD5 );               // keycode
        r( WXK_NUMPAD6 );               // keycode
        r( WXK_NUMPAD7 );               // keycode
        r( WXK_NUMPAD8 );               // keycode
        r( WXK_NUMPAD9 );               // keycode
        r( WXK_MULTIPLY );              // keycode
        r( WXK_ADD );                   // keycode
        r( WXK_SEPARATOR );             // keycode
        r( WXK_SUBTRACT );              // keycode
        r( WXK_DECIMAL );               // keycode
        r( WXK_DIVIDE );                // keycode
        r( WXK_F1 );                    // keycode
        r( WXK_F2 );                    // keycode
        r( WXK_F3 );                    // keycode
        r( WXK_F4 );                    // keycode
        r( WXK_F5 );                    // keycode
        r( WXK_F6 );                    // keycode
        r( WXK_F7 );                    // keycode
        r( WXK_F8 );                    // keycode
        r( WXK_F9 );                    // keycode
        r( WXK_F10 );                   // keycode
        r( WXK_F11 );                   // keycode
        r( WXK_F12 );                   // keycode
        r( WXK_F13 );                   // keycode
        r( WXK_F14 );                   // keycode
        r( WXK_F15 );                   // keycode
        r( WXK_F16 );                   // keycode
        r( WXK_F17 );                   // keycode
        r( WXK_F18 );                   // keycode
        r( WXK_F19 );                   // keycode
        r( WXK_F20 );                   // keycode
        r( WXK_F21 );                   // keycode
        r( WXK_F22 );                   // keycode
        r( WXK_F23 );                   // keycode
        r( WXK_F24 );                   // keycode
        r( WXK_NUMLOCK );               // keycode
        r( WXK_SCROLL  );               // keycode
    }
    break;
  case 'L':
    r( wxLB_SINGLE );                   // listbox
    r( wxLB_MULTIPLE );                 // listbox
    r( wxLB_EXTENDED );                 // listbox
    r( wxLB_HSCROLL );                  // listbox
    r( wxLB_ALWAYS_SB );                // listbox
    r( wxLB_NEEDED_SB );                // listbox
    r( wxLB_SORT );                     // listbox
    r( wxLEFT );                        // sizer layout constraints
    r( wxLIGHT );                       // font

    r( wxLIST_AUTOSIZE );               // listctrl
    r( wxLIST_AUTOSIZE_USEHEADER );     // listctrl

    r( wxLIST_ALIGN_DEFAULT );          // listctrl
    r( wxLIST_ALIGN_LEFT );             // listctrl
    r( wxLIST_ALIGN_TOP );              // listctrl
    r( wxLIST_ALIGN_SNAP_TO_GRID );     // listctrl

    r( wxLIST_FORMAT_LEFT );            // listctrl
    r( wxLIST_FORMAT_RIGHT );           // listctrl
    r( wxLIST_FORMAT_CENTRE );          // listctrl

    r( wxLIST_HITTEST_ABOVE );          // listctrl
    r( wxLIST_HITTEST_BELOW );          // listctrl
    r( wxLIST_HITTEST_NOWHERE );        // listctrl
    r( wxLIST_HITTEST_ONITEMICON );     // listctrl
    r( wxLIST_HITTEST_ONITEMLABEL );    // listctrl
    r( wxLIST_HITTEST_ONITEMRIGHT );    // listctrl
    r( wxLIST_HITTEST_ONITEMSTATEICON );// listctrl
    r( wxLIST_HITTEST_TOLEFT );         // listctrl
    r( wxLIST_HITTEST_TORIGHT );        // listctrl
    r( wxLIST_HITTEST_ONITEM );         // listctrl

    r( wxLIST_MASK_STATE );             // listctrl
    r( wxLIST_MASK_TEXT );              // listctrl
    r( wxLIST_MASK_IMAGE );             // listctrl
    r( wxLIST_MASK_DATA );              // listctrl
    r( wxLIST_MASK_WIDTH );             // listctrl
    r( wxLIST_MASK_FORMAT );            // listctrl

    r( wxLIST_NEXT_ABOVE );             // listctrl
    r( wxLIST_NEXT_ALL );               // listctrl
    r( wxLIST_NEXT_BELOW );             // listctrl
    r( wxLIST_NEXT_LEFT );              // listctrl
    r( wxLIST_NEXT_RIGHT );             // listctrl

    r( wxLIST_STATE_DONTCARE );         // listctrl
    r( wxLIST_STATE_DROPHILITED );      // listctrl
    r( wxLIST_STATE_FOCUSED );          // listctrl
    r( wxLIST_STATE_SELECTED );         // listctrl
    r( wxLIST_STATE_CUT );              // listctrl

    r( wxLIST_SET_ITEM );               // listctrl
#if WXPERL_W_VERSION_GE( 2, 3 )
    r( wxLC_VRULES );                   // listctrl
    r( wxLC_HRULES );                   // listctrl
#endif
    r( wxLC_ICON );                     // listctrl
    r( wxLC_SMALL_ICON );               // listctrl
    r( wxLC_LIST );                     // listctrl
    r( wxLC_REPORT );                   // listctrl
    r( wxLC_ALIGN_TOP );                // listctrl
    r( wxLC_ALIGN_LEFT );               // listctrl
    r( wxLC_AUTOARRANGE );              // listctrl
    r( wxLC_USER_TEXT );                // listctrl
    r( wxLC_EDIT_LABELS );              // listctrl
    r( wxLC_NO_HEADER );                // listctrl
    r( wxLC_SINGLE_SEL );               // listctrl
    r( wxLC_SORT_ASCENDING );           // listctrl
    r( wxLC_SORT_DESCENDING );          // listctrl

    r( wxLI_HORIZONTAL );               // staticline
    r( wxLI_VERTICAL );                 // staticline

    r( wxLONG_DASH );                   // pen

    r( wxLeft );                        // layout constraints
    r( wxLeftOf );                      // layout constraints

#if WXPERL_W_VERSION_GE( 2, 3 )
    r( wxLOCALE_LOAD_DEFAULT );         // locale
    r( wxLOCALE_CONV_ENCODING );        // locale

    if( strnEQ( name, "wxLANGUAGE_", 11 ) )
    {
#define rr( n ) \
    if( strEQ( nm, #n ) ) \
        return wxLANGUAGE_##n;
        //prefix wxLANGUAGE_
        const char* nm = name + 11;

        rr( DEFAULT );                  // locale
        rr( UNKNOWN );                  // locale
        rr( ABKHAZIAN );                // locale
        rr( AFAR );                     // locale
        rr( AFRIKAANS );                // locale
        rr( ALBANIAN );                 // locale
        rr( AMHARIC );                  // locale
        rr( ARABIC );                   // locale
        rr( ARABIC_ALGERIA );           // locale
        rr( ARABIC_BAHRAIN );           // locale
        rr( ARABIC_EGYPT );             // locale
        rr( ARABIC_IRAQ );              // locale
        rr( ARABIC_JORDAN );            // locale
        rr( ARABIC_KUWAIT );            // locale
        rr( ARABIC_LEBANON );           // locale
        rr( ARABIC_LIBYA );             // locale
        rr( ARABIC_MOROCCO );           // locale
        rr( ARABIC_OMAN );              // locale
        rr( ARABIC_QATAR );             // locale
        rr( ARABIC_SAUDI_ARABIA );      // locale
        rr( ARABIC_SUDAN );             // locale
        rr( ARABIC_SYRIA );             // locale
        rr( ARABIC_TUNISIA );           // locale
        rr( ARABIC_UAE );               // locale
        rr( ARABIC_YEMEN );             // locale
        rr( ARMENIAN );                 // locale
        rr( ASSAMESE );                 // locale
        rr( AYMARA );                   // locale
        rr( AZERI );                    // locale
        rr( AZERI_CYRILLIC );           // locale
        rr( AZERI_LATIN );              // locale
        rr( BASHKIR );                  // locale
        rr( BASQUE );                   // locale
        rr( BELARUSIAN );               // locale
        rr( BENGALI );                  // locale
        rr( BHUTANI );                  // locale
        rr( BIHARI );                   // locale
        rr( BISLAMA );                  // locale
        rr( BRETON );                   // locale
        rr( BULGARIAN );                // locale
        rr( BURMESE );                  // locale
        rr( CAMBODIAN );                // locale
        rr( CATALAN );                  // locale
        rr( CHINESE );                  // locale
        rr( CHINESE_SIMPLIFIED );       // locale
        rr( CHINESE_TRADITIONAL );      // locale
        rr( CHINESE_HONGKONG );         // locale
        rr( CHINESE_MACAU );            // locale
        rr( CHINESE_SINGAPORE );        // locale
        rr( CHINESE_TAIWAN );           // locale
        rr( CORSICAN );                 // locale
        rr( CROATIAN );                 // locale
        rr( CZECH );                    // locale
        rr( DANISH );                   // locale
        rr( DUTCH );                    // locale
        rr( DUTCH_BELGIAN );            // locale
        rr( ENGLISH );                  // locale
        rr( ENGLISH_UK );               // locale
        rr( ENGLISH_US );               // locale
        rr( ENGLISH_AUSTRALIA );        // locale
        rr( ENGLISH_BELIZE );           // locale
        rr( ENGLISH_BOTSWANA );         // locale
        rr( ENGLISH_CANADA );           // locale
        rr( ENGLISH_CARIBBEAN );        // locale
        rr( ENGLISH_DENMARK );          // locale
        rr( ENGLISH_EIRE );             // locale
        rr( ENGLISH_JAMAICA );          // locale
        rr( ENGLISH_NEW_ZEALAND );      // locale
        rr( ENGLISH_PHILIPPINES );      // locale
        rr( ENGLISH_SOUTH_AFRICA );     // locale
        rr( ENGLISH_TRINIDAD );         // locale
        rr( ENGLISH_ZIMBABWE );         // locale
        rr( ESPERANTO );                // locale
        rr( ESTONIAN );                 // locale
        rr( FAEROESE );                 // locale
        rr( FARSI );                    // locale
        rr( FIJI );                     // locale
        rr( FINNISH );                  // locale
        rr( FRENCH );                   // locale
        rr( FRENCH_BELGIAN );           // locale
        rr( FRENCH_CANADIAN );          // locale
        rr( FRENCH_LUXEMBOURG );        // locale
        rr( FRENCH_MONACO );            // locale
        rr( FRENCH_SWISS );             // locale
        rr( FRISIAN );                  // locale
        rr( GALICIAN );                 // locale
        rr( GEORGIAN );                 // locale
        rr( GERMAN );                   // locale
        rr( GERMAN_AUSTRIAN );          // locale
        rr( GERMAN_BELGIUM );           // locale
        rr( GERMAN_LIECHTENSTEIN );     // locale
        rr( GERMAN_LUXEMBOURG );        // locale
        rr( GERMAN_SWISS );             // locale
        rr( GREEK );                    // locale
        rr( GREENLANDIC );              // locale
        rr( GUARANI );                  // locale
        rr( GUJARATI );                 // locale
        rr( HAUSA );                    // locale
        rr( HEBREW );                   // locale
        rr( HINDI );                    // locale
        rr( HUNGARIAN );                // locale
        rr( ICELANDIC );                // locale
        rr( INDONESIAN );               // locale
        rr( INTERLINGUA );              // locale
        rr( INTERLINGUE );              // locale
        rr( INUKTITUT );                // locale
        rr( INUPIAK );                  // locale
        rr( IRISH );                    // locale
        rr( ITALIAN );                  // locale
        rr( ITALIAN_SWISS );            // locale
        rr( JAPANESE );                 // locale
        rr( JAVANESE );                 // locale
        rr( KANNADA );                  // locale
        rr( KASHMIRI );                 // locale
        rr( KASHMIRI_INDIA );           // locale
        rr( KAZAKH );                   // locale
        rr( KERNEWEK );                 // locale
        rr( KINYARWANDA );              // locale
        rr( KIRGHIZ );                  // locale
        rr( KIRUNDI );                  // locale
        rr( KONKANI );                  // locale
        rr( KOREAN );                   // locale
        rr( KURDISH );                  // locale
        rr( LAOTHIAN );                 // locale
        rr( LATIN );                    // locale
        rr( LATVIAN );                  // locale
        rr( LINGALA );                  // locale
        rr( LITHUANIAN );               // locale
        rr( MACEDONIAN );               // locale
        rr( MALAGASY );                 // locale
        rr( MALAY );                    // locale
        rr( MALAYALAM );                // locale
        rr( MALAY_BRUNEI_DARUSSALAM );  // locale
        rr( MALAY_MALAYSIA );           // locale
        rr( MALTESE );                  // locale
        rr( MANIPURI );                 // locale
        rr( MAORI );                    // locale
        rr( MARATHI );                  // locale
        rr( MOLDAVIAN );                // locale
        rr( MONGOLIAN );                // locale
        rr( NAURU );                    // locale
        rr( NEPALI );                   // locale
        rr( NEPALI_INDIA );             // locale
        rr( NORWEGIAN_BOKMAL );         // locale
        rr( NORWEGIAN_NYNORSK );        // locale
        rr( OCCITAN );                  // locale
        rr( ORIYA );                    // locale
        rr( OROMO );                    // locale
        rr( PASHTO );                   // locale
        rr( POLISH );                   // locale
        rr( PORTUGUESE );               // locale
        rr( PORTUGUESE_BRAZILIAN );     // locale
        rr( PUNJABI );                  // locale
        rr( QUECHUA );                  // locale
        rr( RHAETO_ROMANCE );           // locale
        rr( ROMANIAN );                 // locale
        rr( RUSSIAN );                  // locale
        rr( RUSSIAN_UKRAINE );          // locale
        rr( SAMOAN );                   // locale
        rr( SANGHO );                   // locale
        rr( SANSKRIT );                 // locale
        rr( SCOTS_GAELIC );             // locale
        rr( SERBIAN );                  // locale
        rr( SERBIAN_CYRILLIC );         // locale
        rr( SERBIAN_LATIN );            // locale
        rr( SERBO_CROATIAN );           // locale
        rr( SESOTHO );                  // locale
        rr( SETSWANA );                 // locale
        rr( SHONA );                    // locale
        rr( SINDHI );                   // locale
        rr( SINHALESE );                // locale
        rr( SISWATI );                  // locale
        rr( SLOVAK );                   // locale
        rr( SLOVENIAN );                // locale
        rr( SOMALI );                   // locale
        rr( SPANISH );                  // locale
        rr( SPANISH_ARGENTINA );        // locale
        rr( SPANISH_BOLIVIA );          // locale
        rr( SPANISH_CHILE );            // locale
        rr( SPANISH_COLOMBIA );         // locale
        rr( SPANISH_COSTA_RICA );       // locale
        rr( SPANISH_DOMINICAN_REPUBLIC ); // locale
        rr( SPANISH_ECUADOR );          // locale
        rr( SPANISH_EL_SALVADOR );      // locale
        rr( SPANISH_GUATEMALA );        // locale
        rr( SPANISH_HONDURAS );         // locale
        rr( SPANISH_MEXICAN );          // locale
        rr( SPANISH_MODERN );           // locale
        rr( SPANISH_NICARAGUA );        // locale
        rr( SPANISH_PANAMA );           // locale
        rr( SPANISH_PARAGUAY );         // locale
        rr( SPANISH_PERU );             // locale
        rr( SPANISH_PUERTO_RICO );      // locale
        rr( SPANISH_URUGUAY );          // locale
        rr( SPANISH_US );               // locale
        rr( SPANISH_VENEZUELA );        // locale
        rr( SUNDANESE );                // locale
        rr( SWAHILI );                  // locale
        rr( SWEDISH );                  // locale
        rr( SWEDISH_FINLAND );          // locale
        rr( TAGALOG );                  // locale
        rr( TAJIK );                    // locale
        rr( TAMIL );                    // locale
        rr( TATAR );                    // locale
        rr( TELUGU );                   // locale
        rr( THAI );                     // locale
        rr( TIBETAN );                  // locale
        rr( TIGRINYA );                 // locale
        rr( TONGA );                    // locale
        rr( TSONGA );                   // locale
        rr( TURKISH );                  // locale
        rr( TURKMEN );                  // locale
        rr( TWI );                      // locale
        rr( UIGHUR );                   // locale
        rr( UKRAINIAN );                // locale
        rr( URDU );                     // locale
        rr( URDU_INDIA );               // locale
        rr( URDU_PAKISTAN );            // locale
        rr( UZBEK );                    // locale
        rr( UZBEK_CYRILLIC );           // locale
        rr( UZBEK_LATIN );              // locale
        rr( VIETNAMESE );               // locale
        rr( VOLAPUK );                  // locale
        rr( WELSH );                    // locale
        rr( WOLOF );                    // locale
        rr( XHOSA );                    // locale
        rr( YIDDISH );                  // locale
        rr( YORUBA );                   // locale
        rr( ZHUANG );                   // locale
        rr( ZULU );                     // locale
        rr( USER_DEFINED );             // locale
        //prefix
#undef rr
    }
#endif
    break;
  case 'M':
    r( wxMAXIMIZE );                    // frame
    r( wxMAXIMIZE_BOX );                // frame
    r( wxMENU_TEAROFF );                // menu
    r( wxMINIMIZE );                    // frame
    r( wxMINIMIZE_BOX );                // frame
    r( wxMODERN );                      // font
    r( wxMULTIPLE );                    // filedialog
    
    r( wxMAJOR_VERSION );
    r( wxMINOR_VERSION );

    r( wxMM_TWIPS );                    // dc
    r( wxMM_POINTS );                   // dc
    r( wxMM_METRIC );                   // dc
    r( wxMM_LOMETRIC );                 // dc
    r( wxMM_TEXT );                     // dc
    break;
  case 'N':
    r( wxNB_FIXEDWIDTH );               // notebook
    r( wxNB_LEFT );                     // notebook
    r( wxNB_RIGHT );                    // notebook
    r( wxNB_BOTTOM );                   // notebook
    r( wxNO_BORDER );                   // frame toolbar
    r( wxNO_3D );                       // dialog window
    r( wxNO_FULL_REPAINT_ON_RESIZE );   // window
    r( wxNORMAL );                      // font
    r( wxNOT_FOUND );             

    r( wxNAND );                        // dc
    r( wxNOR );                         // dc
    r( wxNO_OP );                       // dc
    break;
  case 'O':
    r( wxOK );
    r( wxOPEN );                        // filedialog
    r( wxOVERWRITE_PROMPT );            // filedialog
    
    r( wxODDEVEN_RULE );                // dc
    r( wxOR );                          // dc
    r( wxOR_INVERT );                   // dc
    r( wxOR_REVERSE );                  // dc

    r( wxOutRegion );                   // region
    break;
  case 'P':
    r( wxPROCESS_ENTER );

    r( wxPD_APP_MODAL );                // progressdialog
    r( wxPD_AUTO_HIDE );                // progressdialog
    r( wxPD_CAN_ABORT );                // progressdialog
    r( wxPD_ELAPSED_TIME );             // progressdialog
    r( wxPD_ESTIMATED_TIME );           // progressdialog
    r( wxPD_REMAINING_TIME );           // progressdialog
    //    r( wxPD_SMOOTH );                   // progressdialog

    r( wxPercentOf );                   // layout constraints
    r( wxPartRegion );                  // layout constraints
    break;
  case 'R':
    r( wxRAISED_BORDER );               // window
    r( wxRA_SPECIFY_ROWS );             // radiobox
    r( wxRA_SPECIFY_COLS );             // radiobox
    r( wxRB_GROUP );                    // radiobutton
    r( wxRESIZE_BORDER );               // dialog frame
    r( wxRETAINED );                    // scrolledwindow
    r( wxRIGHT );                       // sizer layout constraints
    r( wxROMAN );                       // font

    r( wxRight );                       // layout constraints
    r( wxRightOf );                     // layout constraints
    break;
  case 'S':
    r( wxSAVE );                        // filedialog
    //    r( wxSB_SIZEGRIP );
    r( wxSB_HORIZONTAL );               // scrollbar
    r( wxSB_VERTICAL );                 // scrollbar
    r( wxSCRIPT );                      // font
    r( wxSIMPLE_BORDER );               // window
    r( wxSLANT );                       // font
    r( wxSTATIC_BORDER );               // window
    r( wxSTAY_ON_TOP );                 // frame dialog
    r( wxST_NO_AUTORESIZE );            // statictext
    r( wxSUNKEN_BORDER );               // window
    r( wxSYSTEM_MENU );                 // frame dialog
    r( wxSWISS );                       // font
    r( wxSL_HORIZONTAL );               // slider
    r( wxSL_VERTICAL );                 // slider
    r( wxSL_AUTOTICKS );                // slider
    r( wxSL_LABELS );                   // slider
    r( wxSL_LEFT );                     // slider
    r( wxSL_RIGHT );                    // slider
    r( wxSL_TOP );                      // slider
    r( wxSL_SELRANGE );                 // slider

    r( wxSIZE_AUTO_WIDTH );             // window
    r( wxSIZE_AUTO_HEIGHT );            // window
    r( wxSIZE_AUTO );                   // window
    r( wxSIZE_USE_EXISTING );           // window
    r( wxSIZE_ALLOW_MINUS_ONE );        // window

    r( wxSP_HORIZONTAL );               // spinbutton
    r( wxSP_VERTICAL );                 // spinbutton
    r( wxSP_ARROW_KEYS );               // spinbutton spinctrl
    r( wxSP_WRAP );                     // spinbutton spinctrl

    r( wxSP_3D );                       // splitterwindow
    r( wxSP_3DSASH );                   // splitterwindow
    r( wxSP_3DBORDER );                 // splitterwindow
    r( wxSP_FULLSASH );                 // splitterwindow
    r( wxSP_BORDER );                   // splitterwindow
    r( wxSP_NOBORDER );                 // splitterwindow
    r( wxSP_PERMIT_UNSPLIT );           // splitterwindow
    r( wxSP_LIVE_UPDATE );              // splitterwindow
    r( wxSPLIT_HORIZONTAL );            // splitterwindow
    r( wxSPLIT_VERTICAL );              // splitterwindow

    r( wxSHAPED );                      // sizer

    r( wxSHORT_DASH );                  // pen
    r( wxSTIPPLE );                     // brush pen
    r( wxSTIPPLE_MASK_OPAQUE );         // brush pen

    r( wxSET );                         // dc
    r( wxSRC_INVERT );                  // dc

    r( wxSOLID );                       // dc brush pen

    r( wxSASH_STATUS_OK );              // sashwindow
    r( wxSASH_STATUS_OUT_OF_RANGE );    // sashwindow
    r( wxSASH_TOP );                    // sashwindow
    r( wxSASH_RIGHT );                  // sashwindow
    r( wxSASH_BOTTOM );                 // sashwindow
    r( wxSASH_LEFT );                   // sashwindow
    r( wxSASH_NONE );                   // sashwindow

    r( wxSW_3D );                       // sashwindow
    r( wxSW_3DSASH );                   // sashwindow
    r( wxSW_3DBORDER );                 // sashwindow
    r( wxSW_BORDER );                   // sashwindow

    r( wxSameAs );                      // layout constraints

    // fonts
    r( wxSYS_OEM_FIXED_FONT );
    r( wxSYS_ANSI_FIXED_FONT );
    r( wxSYS_ANSI_VAR_FONT );
    r( wxSYS_SYSTEM_FONT ); 
    r( wxSYS_DEVICE_DEFAULT_FONT );
    r( wxSYS_DEFAULT_GUI_FONT );

    // colours
    r( wxSYS_COLOUR_SCROLLBAR );
    r( wxSYS_COLOUR_BACKGROUND );
    r( wxSYS_COLOUR_ACTIVECAPTION );
    r( wxSYS_COLOUR_INACTIVECAPTION );
    r( wxSYS_COLOUR_MENU );
    r( wxSYS_COLOUR_WINDOW );
    r( wxSYS_COLOUR_WINDOWFRAME );
    r( wxSYS_COLOUR_MENUTEXT );
    r( wxSYS_COLOUR_WINDOWTEXT );
    r( wxSYS_COLOUR_CAPTIONTEXT );
    r( wxSYS_COLOUR_ACTIVEBORDER );
    r( wxSYS_COLOUR_INACTIVEBORDER );
    r( wxSYS_COLOUR_APPWORKSPACE );
    r( wxSYS_COLOUR_HIGHLIGHT );
    r( wxSYS_COLOUR_HIGHLIGHTTEXT );
    r( wxSYS_COLOUR_BTNFACE );
    r( wxSYS_COLOUR_BTNSHADOW );
    r( wxSYS_COLOUR_GRAYTEXT );
    r( wxSYS_COLOUR_BTNTEXT );
    r( wxSYS_COLOUR_INACTIVECAPTIONTEXT );
    r( wxSYS_COLOUR_BTNHIGHLIGHT );

    r( wxSYS_COLOUR_3DDKSHADOW );
    r( wxSYS_COLOUR_3DLIGHT );
    r( wxSYS_COLOUR_INFOTEXT );
    r( wxSYS_COLOUR_INFOBK );

    r( wxSYS_COLOUR_LISTBOX );

    r( wxSYS_COLOUR_DESKTOP );
    r( wxSYS_COLOUR_3DFACE );
    r( wxSYS_COLOUR_3DSHADOW );
    r( wxSYS_COLOUR_3DHIGHLIGHT );
    r( wxSYS_COLOUR_3DHILIGHT );
    r( wxSYS_COLOUR_BTNHILIGHT );

    // metrics
    r( wxSYS_MOUSE_BUTTONS );
    r( wxSYS_BORDER_X );
    r( wxSYS_BORDER_Y );
    r( wxSYS_CURSOR_X );
    r( wxSYS_CURSOR_Y );
    r( wxSYS_DCLICK_X );
    r( wxSYS_DCLICK_Y );
    r( wxSYS_DRAG_X );
    r( wxSYS_DRAG_Y );
    r( wxSYS_EDGE_X );
    r( wxSYS_EDGE_Y );
    r( wxSYS_HSCROLL_ARROW_X );
    r( wxSYS_HSCROLL_ARROW_Y );
    r( wxSYS_HTHUMB_X );
    r( wxSYS_ICON_X );
    r( wxSYS_ICON_Y );
    r( wxSYS_ICONSPACING_X );
    r( wxSYS_ICONSPACING_Y );
    r( wxSYS_WINDOWMIN_X );
    r( wxSYS_WINDOWMIN_Y );
    r( wxSYS_SCREEN_X );
    r( wxSYS_SCREEN_Y );
    r( wxSYS_FRAMESIZE_X );
    r( wxSYS_FRAMESIZE_Y );
    r( wxSYS_SMALLICON_X );
    r( wxSYS_SMALLICON_Y );
    r( wxSYS_HSCROLL_Y );
    r( wxSYS_VSCROLL_X );
    r( wxSYS_VSCROLL_ARROW_X );
    r( wxSYS_VSCROLL_ARROW_Y );
    r( wxSYS_VTHUMB_Y );
    r( wxSYS_CAPTION_Y );
    r( wxSYS_MENU_Y );
    r( wxSYS_NETWORK_PRESENT );
    r( wxSYS_PENWINDOWS_PRESENT );
    r( wxSYS_SHOW_SOUNDS );
    r( wxSYS_SWAP_BUTTONS );

    break;
  case 'T':
    r( wxTAB_TRAVERSAL );               // panel
    r( wxTB_FLAT );                     // toolbar
    r( wxTB_DOCKABLE );                 // toolbar
    r( wxTB_HORIZONTAL );               // toolbar
    r( wxTB_VERTICAL );                 // toolbar
    r( wxTB_3DBUTTONS );                // toolbar
    r( wxTE_PROCESS_ENTER );            // textctrl
    r( wxTE_PROCESS_TAB );              // textctrl
    r( wxTE_MULTILINE );                // textctrl
    r( wxTE_PASSWORD );                 // textctrl
    r( wxTE_READONLY );                 // textctrl
    r( wxTE_RICH );                     // textctrl
    r( wxTHICK_FRAME );                 // frame dialog
    r( wxTOP );                         // sizer layout constraints
    r( wxTRANSPARENT_WINDOW );          // window
    r( wxTRANSPARENT );                 // dc brush pen

    r( wxTR_HAS_BUTTONS );              // treectrl
    r( wxTR_EDIT_LABELS );              // treectrl
    r( wxTR_MULTIPLE );                 // treectrl

    r( wxTreeItemIcon_Normal );         // treectrl
    r( wxTreeItemIcon_Selected );       // treectrl
    r( wxTreeItemIcon_Expanded );       // treectrl
    r( wxTreeItemIcon_SelectedExpanded ); // treectrl

    r( wxTREE_HITTEST_ABOVE );          // treectrl
    r( wxTREE_HITTEST_BELOW );          // treectrl
    r( wxTREE_HITTEST_NOWHERE );        // treectrl
    r( wxTREE_HITTEST_ONITEMBUTTON );   // treectrl
    r( wxTREE_HITTEST_ONITEMICON );     // treectrl
    r( wxTREE_HITTEST_ONITEMINDENT );   // treectrl
    r( wxTREE_HITTEST_ONITEMLABEL );    // treectrl
    r( wxTREE_HITTEST_ONITEMRIGHT );    // treectrl
    r( wxTREE_HITTEST_ONITEMSTATEICON ); // treectrl
    r( wxTREE_HITTEST_TOLEFT );         // treectrl
    r( wxTREE_HITTEST_TORIGHT );        // treectrl
    r( wxTREE_HITTEST_ONITEMUPPERPART ); // treectrl
    r( wxTREE_HITTEST_ONITEMLOWERPART ); // treectrl
    r( wxTREE_HITTEST_ONITEM );         // treectrl

    r( wxTop );                         // layout constraints
    break;
  case 'U':
    r( wxUnconstrained );               // layout constraints

    r( wxUSER_DASH );                   // pen
    break;
  case 'V':
    r( wxVERTICAL );                    // window dialog frame sizer
    r( wxVERTICAL_HATCH );              // brush pen
    r( wxVSCROLL );                     // window
    break;
  case 'W':
    r( wxWANTS_CHARS );
    r( wxWINDING_RULE );                // dc
    r( wxWidth );                       // layout constraints

    break;
  case 'X':
    r( wxXOR );                         // dc
    break;
  case 'Y':
    r( wxYES );
    r( wxYES_NO );
    break;
  default:
    break;
  }

#undef r

  errno = EINVAL;
  return 0;

 not_there:
  errno = ENOENT;
  return 0;
}

void SetConstants()
{
    SV* tmp;

    tmp = get_sv( "Wx::_default_position", 0 );
    sv_setref_pv( tmp, "Wx::Point", new wxPoint( wxDefaultPosition ) );

    tmp = get_sv( "Wx::_default_size", 0 );
    sv_setref_pv( tmp, "Wx::Size", new wxSize( wxDefaultSize ) );

    tmp = get_sv( "Wx::_default_validator", 0 );
    sv_setref_pv( tmp, "Wx::Validator", (wxValidator*)&wxDefaultValidator );
  
    //
    // Null GDI objects
    //
    tmp = get_sv( "Wx::_null_bitmap", 0 );
    sv_setref_pv( tmp, "Wx::Bitmap", new wxBitmap( wxNullBitmap ) );

    tmp = get_sv( "Wx::_null_icon", 0 );
    sv_setref_pv( tmp, "Wx::Icon", new wxIcon( wxNullIcon ) );

    tmp = get_sv( "Wx::_null_colour", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( wxNullColour ) );

    tmp = get_sv( "Wx::_null_cursor", 0 );
    sv_setref_pv( tmp, "Wx::Cursor", new wxCursor( wxNullCursor ) );

    tmp = get_sv( "Wx::_null_font", 0 );
    sv_setref_pv( tmp, "Wx::Font", new wxFont( wxNullFont ) );

    tmp = get_sv( "Wx::_null_pen", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( wxNullPen ) );

    tmp = get_sv( "Wx::_null_brush", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( wxNullBrush ) );

    tmp = get_sv( "Wx::_null_palette", 0 );
    sv_setref_pv( tmp, "Wx::Palette", new wxPalette( wxNullPalette ) );

    tmp = get_sv( "Wx::_null_accelerator", 0 );
    sv_setref_pv( tmp, "Wx::AcceleratorTable",
        new wxAcceleratorTable( wxNullAcceleratorTable ) );

    //
    // Predefined colours
    //
    tmp = get_sv( "Wx::_colour_black", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxBLACK ) );

    tmp = get_sv( "Wx::_colour_red", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxRED ) );

    tmp = get_sv( "Wx::_colour_green", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxGREEN ) );

    tmp = get_sv( "Wx::_colour_blue", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxBLUE ) );

    tmp = get_sv( "Wx::_colour_white", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxWHITE ) );

    tmp = get_sv( "Wx::_colour_cyan", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxCYAN ) );

    tmp = get_sv( "Wx::_colour_light_grey", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxLIGHT_GREY ) );


    //
    // predefined cursors
    //
    tmp = get_sv( "Wx::_cursor_standard", 0 );
    sv_setref_pv( tmp, "Wx::Cursor", new wxCursor( *wxSTANDARD_CURSOR ) );

    tmp = get_sv( "Wx::_cursor_hourglass", 0 );
    sv_setref_pv( tmp, "Wx::Cursor", new wxCursor( *wxHOURGLASS_CURSOR ) );

    tmp = get_sv( "Wx::_cursor_cross", 0 );
    sv_setref_pv( tmp, "Wx::Cursor", new wxCursor( *wxCROSS_CURSOR ) );

    //
    // predefined fonts
    //
    tmp = get_sv( "Wx::_font_normal", 0 );
    sv_setref_pv( tmp, "Wx::Font", new wxFont( *wxNORMAL_FONT ) );

    tmp = get_sv( "Wx::_font_small", 0 );
    sv_setref_pv( tmp, "Wx::Font", new wxFont( *wxSMALL_FONT ) );

    tmp = get_sv( "Wx::_font_italic", 0 );
    sv_setref_pv( tmp, "Wx::Font", new wxFont( *wxITALIC_FONT ) );

    tmp = get_sv( "Wx::_font_swiss", 0 );
    sv_setref_pv( tmp, "Wx::Font", new wxFont( *wxSWISS_FONT ) );

    //
    // predefined pens
    //
    tmp = get_sv( "Wx::_pen_red", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxRED_PEN ) );

    tmp = get_sv( "Wx::_pen_cyan", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxCYAN_PEN ) );

    tmp = get_sv( "Wx::_pen_green", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxGREEN_PEN ) );

    tmp = get_sv( "Wx::_pen_black", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxBLACK_PEN ) );

    tmp = get_sv( "Wx::_pen_white", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxWHITE_PEN ) );

    tmp = get_sv( "Wx::_pen_transparent", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxTRANSPARENT_PEN ) );

    tmp = get_sv( "Wx::_pen_black_dashed", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxBLACK_DASHED_PEN ) );

    tmp = get_sv( "Wx::_pen_grey", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxGREY_PEN ) );

    tmp = get_sv( "Wx::_pen_medium_grey", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxMEDIUM_GREY_PEN ) );

    tmp = get_sv( "Wx::_pen_light_grey", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxLIGHT_GREY_PEN ) );

    //
    // Predefined brushes
    //
    tmp = get_sv( "Wx::_brush_blue", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxBLUE_BRUSH ) );

    tmp = get_sv( "Wx::_brush_green", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxGREEN_BRUSH ) );

    tmp = get_sv( "Wx::_brush_white", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxWHITE_BRUSH ) );

    tmp = get_sv( "Wx::_brush_black", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxBLACK_BRUSH ) );

    tmp = get_sv( "Wx::_brush_grey", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxGREY_BRUSH ) );

    tmp = get_sv( "Wx::_brush_medium_grey", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxMEDIUM_GREY_BRUSH ) );

    tmp = get_sv( "Wx::_brush_light_grey", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxLIGHT_GREY_BRUSH ) );

    tmp = get_sv( "Wx::_brush_transparent", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxTRANSPARENT_BRUSH ) );

    tmp = get_sv( "Wx::_brush_cyan", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxCYAN_BRUSH ) );

    tmp = get_sv( "Wx::_brush_red", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxRED_BRUSH ) );
  
    //
    // Miscellaneous
    //
    tmp = get_sv( "Wx::_version_string", 0 );
    sv_setpv( tmp, wxVERSION_STRING );

    tmp = get_sv( "Wx::_wx_version", 0 );
    sv_setnv( tmp, wxMAJOR_VERSION + wxMINOR_VERSION / 1000.0 );

    tmp = get_sv( "Wx::_platform", 0 );
#if __WXMSW__
    sv_setiv( tmp, 1 );
#elif __WXGTK__
    sv_setiv( tmp, 2 );
#else
    sv_setiv( tmp, 3 );
#endif
}

MODULE=Wx_Const PACKAGE=Wx

double
constant(name,arg)
    const char* name
    int arg



