#############################################################################
## Name:        nmake
## Purpose:     extracts some flag information from makevc.env
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

NOPCH=1
WXUSINGDLL=1
!ifndef FINAL
FINAL=1
!endif

!include $(WXWIN)\src\makevc.env

wxdir:
    echo $(WXWIN)

cccflags:
    echo $(CPPFLAGS)

linkflags:
    echo $(LINKFLAGS)

libs:
    echo $(LIBS)
