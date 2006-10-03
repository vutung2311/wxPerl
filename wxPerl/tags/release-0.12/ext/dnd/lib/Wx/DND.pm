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

use vars qw($VERSION);

$VERSION = '0.01';

Wx::wx_boot( 'Wx::DND', $VERSION );

use Wx::DropSource;

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
package Wx::PlDropTarget;       @ISA = qw(Wx::DropTarget);
package Wx::TextDropTarget;     @ISA = qw(Wx::DropTarget);
package Wx::FileDropTarget;     @ISA = qw(Wx::DropTarget);
package Wx::URLDataObject;      @ISA = qw(Wx::DataObject);

use strict;

#
# constants
#

package Wx;

use vars qw($_df_invalid $_df_bitmap $_df_text $_df_metafile $_df_filename);

# !parser: sub { $_[0] =~ m/^\s*sub\s+(wx\w+)[^\}]*\}\s*(?:\#(.*))?$/ }
# !package: Wx
# !tag: dnd clipboard

sub wxDF_INVALID { $_df_invalid }
sub wxDF_TEXT { $_df_text }
sub wxDF_BITMAP { $_df_bitmap }
sub wxDF_METAFILE { $_df_metafile }
sub wxDF_FILENAME { $_df_filename }

SetDNDConstants();

1;

# Local variables: #
# mode: cperl #
# End: #

