#############################################################################
## Name:        Html.pm
## Purpose:     Wx::Html ( pulls in all Wx::Html* stuff )
## Author:      Mattia Barbon
## Modified by:
## Created:     17/ 3/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Html;

use Wx;
use strict;

require DynaLoader;

use vars qw(@ISA $VERSION);

$VERSION = '0.01';

@ISA = qw(DynaLoader);

Wx::wx_boot( 'Wx::Html', $VERSION );

#
# properly setup inheritance tree
#

no strict;

package Wx::HtmlWindow;   @ISA = qw(Wx::ScrolledWindow);
package Wx::HtmlHelpController; @ISA = qw(Wx::HelpControllerBase);

1;

# Local variables: #
# mode: cperl #
# End: #
