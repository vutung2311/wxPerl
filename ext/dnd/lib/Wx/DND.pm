#############################################################################
## Name:        DND.pm
## Purpose:     Wx::DND pulls in all wxWindows Drag'n'Drop and Clipboard
## Author:      Mattia Barbon
## Modified by:
## Created:     12/ 8/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::DND;

use Wx;
use strict;

require DynaLoader;

use vars qw(@ISA $VERSION);

$VERSION = '0.01';

@ISA = qw(DynaLoader);

bootstrap Wx::DND;

#
# properly setup inheritance tree
#

no strict;

package Wx::DropFilesEvent;     @ISA = qw(Wx::Event);
package Wx::DataObject;
package Wx::DataObjectSimple;   @ISA = qw(Wx::DataObject);
package Wx::PlDataObjectSimple; @ISA = qw(Wx::DataObjectSimple);
package Wx::DataObjectComposite;@ISA = qw(Wx::DataObject);
package Wx::FileDataObject;     @ISA = qw(Wx::DataObjectSimple);
package Wx::TextDataObject;     @ISA = qw(Wx::DataObjectSimple);
package Wx::BitmapDataObject;   @ISA = qw(Wx::DataObjectSimple);
package Wx::Droptarget;
package Wx::TextDropTarget;     @ISa = qw(Wx::DropTarget);
package Wx::FileDropTarget;     @ISa = qw(Wx::DropTarget);

use strict;

1;

# Local variables: #
# mode: cperl #
# End: #


