#############################################################################
## Name:        MDI.pm
## Purpose:     Wx::MDI ( pulls in all MDI )
## Author:      Mattia Barbon
## Modified by:
## Created:      6/ 9/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::MDI;

use Wx;
use strict;

use vars qw($VERSION);

$VERSION = '0.01';

Wx::wx_boot( 'Wx::MDI', $VERSION );

# init wxModules

#
# properly setup inheritance tree
#

no strict;

package Wx::MDIParentFrame;     @ISA = qw(Wx::Frame);
package Wx::MDIChildFrame;      @ISA = qw(Wx::Frame);
package Wx::MDIClientWindow;    @ISA = qw(Wx::Window);

use strict;

1;

# Local variables: #
# mode: cperl #
# End: #

