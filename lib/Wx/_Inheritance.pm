#############################################################################
## Name:        _Inheritance.pm
## Purpose:     set inheritance tree
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

no strict;

package Wx::EvtHandler;
package Wx::Window;                     @ISA = qw(Wx::EvtHandler);
package Wx::Menu;                       @ISA = qw(Wx::EvtHandler);
package Wx::MenuBar;                    @ISA = qw(Wx::Window);
package Wx::MenuItem;
package Wx::TopLevelWindow;             @ISA = qw(Wx::Window);
package Wx::_App;                       @ISA = qw(Wx::EvtHandler);
package Wx::Panel;                      @ISA = qw(Wx::Window);
package Wx::Control;                    @ISA = qw(Wx::Window);
package Wx::Button;                     @ISA = qw(Wx::Control);
package Wx::BitmapButton;               @ISA = qw(Wx::Button);
package Wx::TextCtrl;                   @ISA = qw(Wx::Control);
package Wx::StaticText;                 @ISA = qw(Wx::Control);
package Wx::CheckBox;                   @ISA = qw(Wx::Control);
package Wx::CheckListBox;               @ISA = qw(Wx::ListBox);
package Wx::ControlWithItems;           @ISA = qw(Wx::Control);
package Wx::Choice;                     @ISA = qw(Wx::ControlWithItems);
package Wx::ListBox;                    @ISA = qw(Wx::ControlWithItems);
package Wx::Notebook;                   @ISA = qw(Wx::Control);
package Wx::ToolBarBase;                @ISA = qw(Wx::Control);
package Wx::ToolBarSimple;              @ISA = qw(Wx::Control);
package Wx::ToolBarToolBase;
package Wx::StaticBitmap;               @ISA = qw(Wx::Control);
package Wx::Gauge;                      @ISA = qw(Wx::Control);
package Wx::Slider;                     @ISA = qw(Wx::Control);
package Wx::SpinCtrl;                   @ISA = qw(Wx::Control);
package Wx::SpinButton;                 @ISA = qw(Wx::Control);
package Wx::RadioBox;                   @ISA = qw(Wx::Control);
package Wx::RadioButton;                @ISA = qw(Wx::Control);
package Wx::StaticLine;                 @ISA = qw(Wx::Control);
package Wx::StaticBox;                  @ISA = qw(Wx::Control);
package Wx::ScrollBar;                  @ISA = qw(Wx::Control);
package Wx::StatusBarGeneric;           @ISA = qw(Wx::Window);
package Wx::GenericScrolledWindow;      @ISA = qw(Wx::Panel);
package Wx::GenericTreeCtrl;            @ISA = qw(Wx::ScrolledWindow);
package Wx::MiniFrame;                  @ISA = qw(Wx::Frame);
package Wx::SplitterWindow;             @ISA = qw(Wx::Window);
package Wx::ListCtrl;                   @ISA = qw(Wx::Control);
package Wx::ListView;                   @ISA = qw(Wx::ListCtrl);
package Wx::SashWindow;                 @ISA = qw(Wx::Window);
package Wx::ToggleButton;               @ISA = qw(Wx::Control);

package Wx::ColourDialog;               @ISA = qw(Wx::Dialog);
package Wx::GenericColourDialog;        @ISA = qw(Wx::ColourDialog);
package Wx::FindReplaceDialog;          @ISA = qw(Wx::Dialog);
package Wx::FontDialog;                 @ISA = qw(Wx::Dialog);
package Wx::DirDialog;                  @ISA = qw(Wx::Dialog);
package Wx::FileDialog;                 @ISA = qw(Wx::Dialog);
package Wx::TextEntryDialog;            @ISA = qw(Wx::Dialog);
package Wx::MessageDialog;              @ISA = qw(Wx::Dialog);
package Wx::ProgressDialog;             @ISA = qw(Wx::Dialog);
package Wx::SingleChoiceDialog;         @ISA = qw(Wx::Dialog);
package Wx::MultiChoiceDialog;          @ISA = qw(Wx::Dialog);

package Wx::Validator;                  @ISA = qw(Wx::EvtHandler);
package Wx::TextValidator;              @ISA = qw(Wx::Validator);
package Wx::GenericValidator;           @ISA = qw(Wx::Validator);
package Wx::PlValidator;                @ISA = qw(Wx::Validator);

package Wx::GDIObject;
package Wx::Font;                       @ISA = qw(Wx::GDIObject);
package Wx::Region;                     @ISA = qw(Wx::GDIObject);
package Wx::Bitmap;                     @ISA = qw(Wx::GDIObject);
package Wx::Brush;                      @ISA = qw(Wx::GDIObject);
package Wx::Pen;                        @ISA = qw(Wx::GDIObject);
package Wx::Palette;                    @ISA = qw(Wx::GDIObject);

package Wx::DC;
package Wx::WindowDC;                   @ISA = qw(Wx::DC);
package Wx::ClientDC;                   @ISA = qw(Wx::WindowDC);

package Wx::Image;
package Wx::ImageHandler;
package Wx::BMPHandler;                 @ISA = qw(Wx::ImageHandler);
package Wx::PNGHandler;                 @ISA = qw(Wx::ImageHandler);
package Wx::JPEGHandler;                @ISA = qw(Wx::ImageHandler);
package Wx::GIFHandler;                 @ISA = qw(Wx::ImageHandler);
package Wx::PCXHandler;                 @ISA = qw(Wx::ImageHandler);
package Wx::PNMHandler;                 @ISA = qw(Wx::ImageHandler);
package Wx::TIFFHandler;                @ISA = qw(Wx::ImageHandler);
package Wx::XPMHandler;                 @ISA = qw(Wx::ImageHandler);
package Wx::IFFHandler;                 @ISA = qw(Wx::ImageHandler);
package Wx::ICOHandler;                 @ISA = qw(Wx::BMPHandler);
package Wx::CURHandler;                 @ISA = qw(Wx::ICOHandler);
package Wx::ANIHandler;                 @ISA = qw(Wx::CURHandler);

package Wx::Log;
package Wx::LogTextCtrl;                @ISA = qw(Wx::Log);
package Wx::LogWindow;                  @ISA = qw(Wx::Log);
package Wx::LogGui;                     @ISA = qw(Wx::Log);

package Wx::Sizer;
package Wx::BoxSizer;                   @ISA = qw(Wx::Sizer);
package Wx::StaticBoxSizer;             @ISA = qw(Wx::BoxSizer);
package Wx::GridSizer;                  @ISA = qw(Wx::Sizer);
package Wx::FlexGridSizer;              @ISA = qw(Wx::GridSizer);
package Wx::NotebookSizer;              @ISA = qw(Wx::Sizer);
package Wx::PlSizer;                    @ISA = qw(Wx::Sizer);

package Wx::TaskBarIcon;                @ISA = qw(Wx::EvtHandler);

package Wx::Process;                    @ISA = qw(Wx::EvtHandler);

if( $] >= 5.005 ) { require Tie::Handle; }

package Wx::Stream;                     @ISA = qw(Tie::Handle);
package Wx::InputStream;                @ISA = qw(Wx::Stream);
package Wx::OutputStream;               @ISA = qw(Wx::Stream);

# this is because the inheritance tree is a bit different between
# wxGTK, wxMSW and wxMotif

use strict;

package Wx::Frame;

use vars qw(@ISA);

@ISA = $Wx::_wx_version >= 2.003002 ? qw(Wx::TopLevelWindow) : qw(Wx::Window);
@ISA = qw(Wx::Window) if &Wx::wxMOTIF;

package Wx::Dialog;

use vars qw(@ISA);

@ISA = $Wx::_wx_version >= 2.003002 ? qw(Wx::TopLevelWindow) : qw(Wx::Panel);
@ISA = qw(Wx::Panel) if &Wx::wxMOTIF;

package Wx::MemoryDC;

use vars qw(@ISA);

if( $Wx::_platform == $Wx::_gtk || $Wx::_platform == $Wx::_motif ) {
  @ISA = qw(Wx::WindowDC);
}
else {
  @ISA = qw(Wx::DC);
}

package Wx::PaintDC;

use vars qw(@ISA);

if( ( $Wx::_platform == $Wx::_gtk || $Wx::_platform == $Wx::_msw )
    && $Wx::_wx_version >= 2.003 ) {
  @ISA = qw(Wx::ClientDC);
}
else {
  @ISA = qw(Wx::WindowDC);
}

package Wx::ScreenDC;

use vars qw(@ISA);

if( $Wx::_platform == $Wx::_gtk ) {
  @ISA = qw(Wx::PaintDC);
}
else {
  @ISA = qw(Wx::WindowDC);
}

package Wx::TreeCtrl;

use vars qw(@ISA);

if( $Wx::_platform == $Wx::_msw ) {
  @ISA = qw(Wx::Control);
} else {
  @ISA = ( $Wx::_wx_version >= 2.003 ?
           qw(Wx::GenericTreeCtrl) :
           qw(Wx::ScrolledWindow) );
}

package Wx::ComboBox;

use vars qw(@ISA);

if( $Wx::_platform == $Wx::_gtk ) {
  @ISA = qw(Wx::Control);
}
else {
  @ISA = qw(Wx::Choice);
}

package Wx::ScrolledWindow;

use vars qw(@ISA);

if( $Wx::_wx_version >= 2.003 ) {
  @ISA = qw(Wx::GenericScrolledWindow);
} else {
  @ISA = qw(Wx::Panel );
}

package Wx::StatusBar;

use vars qw(@ISA);

if( $Wx::_platform == $Wx::_gtk ) {
  @ISA = qw(Wx::StatusBarGeneric);
}
else {
  @ISA = qw(Wx::Window);
}

package Wx::Cursor;

use vars qw(@ISA);

if( $Wx::_platform == $Wx::_motif ) {
  @ISA = qw(Wx::Bitmap);
}
elsif( $Wx::_platform == $Wx::_gtk ) {
}
else {
  @ISA = qw(Wx::GDIObject);
}

package Wx::Icon;

use vars qw(@ISA);

if( $Wx::_platform == $Wx::_gtk || $Wx::_platform == $Wx::_motif ) {
  @ISA = qw(Wx::Bitmap);
}
else {
  @ISA = qw(Wx::GDIObject);
}

package Wx::Colour;

if( $Wx::_platform == $Wx::_gtk ) {
  @Wx::Colour::ISA = qw(Wx::GDIObject);
} else {
}

package Wx::PlValidator;

# avoids a 'Attempt to free unreferenced scalar' warning
sub DESTROY {}

no strict;

package Wx::ToolBar;

@ISA = Wx::wxUNIVERSAL ? qw(Wx::ToolBarSimple) : qw(Wx::ToolBarBase);

1;

# Local variables: #
# mode: cperl #
# End: #
