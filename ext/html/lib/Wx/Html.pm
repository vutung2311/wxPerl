#############################################################################
## Name:        ext/html/lib/Wx/Html.pm
## Purpose:     Wx::Html (pulls in all Wx::Html* stuff)
## Author:      Mattia Barbon
## Modified by:
## Created:     17/03/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2007, 2009 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Html;

use Wx;
use strict;

use vars qw($VERSION);

$VERSION = '0.01';

Wx::load_dll( 'net' );
Wx::load_dll( 'html' );
Wx::wx_boot( 'Wx::Html', $VERSION );

#
# properly setup inheritance tree
#

no strict;

package Wx::HelpControllerBase; #warning fix

# !module: Wx::Html
# BEGIN packages
package Wx::HtmlWindow;         @ISA = qw(Wx::ScrolledWindow);     undef *AUTOLOAD;
package Wx::HtmlHelpController; @ISA = qw(Wx::HelpControllerBase); undef *AUTOLOAD;
package Wx::HtmlParser;                                            undef *AUTOLOAD;
package Wx::HtmlWinParser;      @ISA = qw(Wx::HtmlParser);         undef *AUTOLOAD;
package Wx::HtmlTag;                                               undef *AUTOLOAD;
package Wx::PlHtmlTag;          @ISA = qw(Wx::HtmlTag);            undef *AUTOLOAD;
package Wx::HtmlTagHandler;                                        undef *AUTOLOAD;
package Wx::PlHtmlTagHandler;   @ISA = qw(Wx::HtmlTagHandler);     undef *AUTOLOAD;
package Wx::HtmlWinTagHandler;  @ISA = qw(Wx::HtmlTagHandler);     undef *AUTOLOAD;
package Wx::PlHtmlWinTagHandler;@ISA = qw(Wx::HtmlWinTagHandler);  undef *AUTOLOAD;
package Wx::HtmlCell;                                              undef *AUTOLOAD;
package Wx::HtmlWordCell;       @ISA = qw(Wx::HtmlCell);           undef *AUTOLOAD;
package Wx::HtmlContainerCell;  @ISA = qw(Wx::HtmlCell);           undef *AUTOLOAD;
package Wx::HtmlFontCell;       @ISA = qw(Wx::HtmlCell);           undef *AUTOLOAD;
package Wx::HtmlColourCell;     @ISA = qw(Wx::HtmlCell);           undef *AUTOLOAD;
package Wx::HtmlWidgetCell;     @ISA = qw(Wx::HtmlCell);           undef *AUTOLOAD;
package Wx::HtmlListBox;        @ISA = qw(Wx::VListBox);           undef *AUTOLOAD;
package Wx::PlHtmlListBox;      @ISA = qw(Wx::HtmlListBox);        undef *AUTOLOAD;
package Wx::SimpleHtmlListBox;  @ISA = qw(Wx::HtmlListBox);        undef *AUTOLOAD;
package Wx::HtmlCellEvent;      @ISA = qw(Wx::CommandEvent);       undef *AUTOLOAD;
package Wx::HtmlLinkEvent;      @ISA = qw(Wx::CommandEvent);       undef *AUTOLOAD;
# END packages

package Wx::Event;

use strict;

sub EVT_HTML_CELL_CLICKED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_HTML_CELL_CLICKED, $_[2] ) }
sub EVT_HTML_CELL_HOVER($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_HTML_CELL_HOVER, $_[2] ) }
sub EVT_HTML_LINK_CLICKED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_HTML_LINK_CLICKED, $_[2] ) }

1;

# Local variables:
# mode: cperl
# End:
