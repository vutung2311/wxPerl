#############################################################################
## Name:        lib/Wx/Threading.pm
## Purpose:     Minimal setup for using threads with Wx
## Author:      Mattia Barbon
## Modified by:
## Created:     24/01/2010
## RCS-ID:      $Id$
## Copyright:   (c) 2010 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Threading;

use strict;

package Wx;

use Wx::Mini;

_start_threads();

sub wxTheApp { $Wx::wxTheApp || wxThreadApp() }

package Wx::PlThreadEvent;

our @ISA = qw(Wx::Event);

our %stash : shared;
SetStash( \%stash );

package Wx::GDIObject;  # warning for non-existent package
package Wx::Object;     # likewise
package Wx::EvtHandler; our @ISA = qw(Wx::Object);
package Wx::_App;       our @ISA = qw(Wx::EvtHandler);

1;
