#############################################################################
## Name:        Menu.xs
## Purpose:     XS for Wx::Menu, Wx::MenuBar, Wx::MenuItem
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Menu

#FIXME// unimplemented
# GetMenuItems
# Insert
# Remove

Wx_Menu*
Wx_Menu::new( title = wxEmptyString, style = 0)
    wxString title
    long style

void
Wx_Menu::AppendString( id, item, help = wxEmptyString, checkable = FALSE )
    int id
    wxString item
    wxString help
    bool checkable
  CODE:
    THIS->Append( id, item, help, checkable );

void
Wx_Menu::AppendSubMenu( id, item, subMenu, helpString = wxEmptyString )
    int id
    wxString item
    Wx_Menu* subMenu
    wxString helpString
  CODE:
    THIS->Append( id, item, subMenu, helpString );

void
Wx_Menu::AppendItem( menuItem )
    Wx_MenuItem* menuItem
  CODE:
    THIS->Append( menuItem );

void
Wx_Menu::AppendSeparator()

void
Wx_Menu::Break()

void
Wx_Menu::Check( id, check )
    int id
    bool check

void
Wx_Menu::DeleteId( id )
    int id
  CODE:
    THIS->Delete( id );

void
Wx_Menu::DeleteItem( item )
    Wx_MenuItem* item
  CODE:
    THIS->Delete( item );

void
Wx_Menu::DestroyId( id )
    int id
  CODE:
    THIS->Destroy( id );

void
Wx_Menu::DestroyItem( item )
    Wx_MenuItem* item
  CODE:
    THIS->Destroy( item );

void
Wx_Menu::Enable( id, enable )
    int id
    bool enable

int
Wx_Menu::FindItem( item )
    SV* item
  PPCODE:
    if( looks_like_number( item ) ) {
      int id = SvIV( item );
      wxMenu* submenu;
      wxMenuItem* ret;

      ret = THIS->FindItem( id, &submenu );

      SV* mi = sv_newmortal();

      if( GIMME_V == G_ARRAY ) {
        EXTEND( SP, 2 );
        SV* sm = sv_newmortal();

        PUSHs( _object_2_sv( mi, ret ) );
        PUSHs( _object_2_sv( sm, submenu ) );
      }
      else {
        EXTEND( SP, 1 );
        PUSHs( _object_2_sv( mi, ret ) );
      }
    }
    else {
#if WXP_VERSION < 5006
      const char* string = SvPV( item, PL_na );
#else
      const char* string = SvPV_nolen( item );
#endif
      int id = THIS->FindItem( string );

      EXTEND( SP, 1 );
      PUSHs( sv_2mortal( newSViv( id ) ) );
    }

wxString
Wx_Menu::GetHelpString( id )
    int id

wxString
Wx_Menu::GetLabel( id )
    int id

int
Wx_Menu::GetMenuItemCount()

wxString
Wx_Menu::GetTitle()

bool
Wx_Menu::IsChecked( id )
    int id

bool
Wx_Menu::IsEnabled( id )
    int id

void
Wx_Menu::SetHelpString( id, helpString )
    int id
    wxString helpString

void
Wx_Menu::SetLabel( id, label )
    int id
    wxString label

void
Wx_Menu::SetTitle( title )
    wxString title

void
Wx_Menu::UpdateUI( source = 0 )
    Wx_EvtHandler* source

MODULE=Wx PACKAGE=Wx::MenuBar

#FIXME// unimplemented
# FindItem
# GetMenu
# Remove
# Replace

Wx_MenuBar*
Wx_MenuBar::new( style = 0 )
    long style

bool
Wx_MenuBar::Append( menu, title )
    Wx_Menu* menu
    wxString title

void
Wx_MenuBar::Check( id, check )
    int id
    bool check

void
Wx_MenuBar::Enable( id, enable )
    int id
    bool enable

void
Wx_MenuBar::EnableTop( pos, enable )
    int pos
    bool enable

int
Wx_MenuBar::FindMenu( title )
    wxString title

int
Wx_MenuBar::FindMenuItem( menuString, itemString )
    wxString menuString
    wxString itemString

wxString
Wx_MenuBar::GetHelpString( id )
    int id

wxString
Wx_MenuBar::GetLabel( id )
    int id

wxString
Wx_MenuBar::GetLabelTop( id )
    int id

int
Wx_MenuBar::GetMenuCount()

bool
Wx_MenuBar::Insert( pos, menu, title )
    int pos
    Wx_Menu* menu
    wxString title

bool
Wx_MenuBar::IsChecked( id )
    int id

bool
Wx_MenuBar::IsEnabled( id )
    int id

void
Wx_MenuBar::Refresh()

void
Wx_MenuBar::SetHelpString( id, helpString )
    int id
    wxString helpString

void
Wx_MenuBar::SetLabel( id, label )
    int id
    wxString label

void
Wx_MenuBar::SetLabelTop( pos, label )
    int pos
    wxString label

MODULE=Wx PACKAGE=Wx::MenuItem

#FIXME// unimplemented
# GetBitmap
# getlabelFromtext
# SetBitmaps

Wx_MenuItem*
Wx_MenuItem::new( parentMenu = 0, id = -1, text = wxEmptyString, helpString = wxEmptyString, checkable = FALSE, subMenu = 0 )
     Wx_Menu* parentMenu
     int id
     wxString text
     wxString helpString
     bool checkable
     Wx_Menu* subMenu

void
Wx_MenuItem::Check( check )
    bool check

# void
# Wx_MenuItem::DeleteSubMenu()

void
Wx_MenuItem::Enable( enable )
    bool enable

#ifdef __WXMSW__
Wx_Colour*
Wx_MenuItem::GetBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetBackgroundColour() );
  OUTPUT:
   RETVAL

Wx_Font*
Wx_MenuItem::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );
  OUTPUT:
    RETVAL

#endif // __WXMSW__

wxString
Wx_MenuItem::GetHelp()

int
Wx_MenuItem::GetId()

wxString
Wx_MenuItem::GetLabel()

#ifdef __WXMSW__

int
Wx_MenuItem::GetMarginWidth()

#endif // __WXMSW__

wxString
Wx_MenuItem::GetText()

Wx_Menu*
Wx_MenuItem::GetSubMenu()

#ifdef __WXMSW__

Wx_Colour*
Wx_MenuItem::GetTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetTextColour() );
  OUTPUT:
    RETVAL

#endif // __WXMSW_

bool
Wx_MenuItem::IsCheckable()

bool
Wx_MenuItem::IsChecked()

bool
Wx_MenuItem::IsEnabled()

bool
Wx_MenuItem::IsSeparator()

#ifdef __WXMSW__

void
Wx_MenuItem::SetBackgroundColour( colour )
    Wx_Colour* colour
  CODE:
    THIS->SetBackgroundColour( *colour );

void
Wx_MenuItem::SetFont( font )
    Wx_Font* font
  CODE:
    THIS->SetFont( *font );

#endif // __WXMSW__

void
Wx_MenuItem::SetHelp( helpString )
    wxString helpString

#ifdef __WXMSW__

void
Wx_MenuItem::SetMarginWidth( width )
    int width

# void
# Wx_MenuItem::SetName( text )
#     wxString text

void
Wx_MenuItem::SetTextColour( colour )
    Wx_Colour* colour
  CODE:
    THIS->SetTextColour( *colour );

#endif // __WXMSW__

