#############################################################################
## Name:        Sizer.xs
## Purpose:     XS for Wx::Sizer and derived classes
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Sizer

#FIXME// unimplemented Wx::PlSizer

void
Wx_Sizer::Destroy()
  CODE:
    delete THIS;

void
Wx_Sizer::AddWindow( window, option = 0, flag = 0, border = 0 )
    Wx_Window* window
    int option
    int flag
    int border
  CODE:
    THIS->Add( window, option, flag, border );

void
Wx_Sizer::AddSizer( sizer, option = 0, flag = 0, border = 0 )
    Wx_Sizer* sizer
    int option
    int flag
    int border
  CODE:
    THIS->Add( sizer, option, flag, border );

void
Wx_Sizer::AddSpace( width, height, option = 0, flag = 0, border = 0 )
    int width
    int height
    int option
    int flag
    int border
  CODE:
    THIS->Add( width, height, option, flag, border );

Wx_Size*
Wx_Sizer::CalcMin()
  CODE:
    RETVAL = new wxSize( THIS->CalcMin() );
  OUTPUT:
    RETVAL

void
Wx_Sizer::Fit( window )
    Wx_Window* window

void
Wx_Sizer::GetChildren()
  PPCODE:
    const wxList& list = THIS->GetChildren();
    wxNode* node;
    
    EXTEND( SP, list.GetCount() );

    for( node = list.GetFirst(); node; node = node->GetNext() )
      PUSHs( _object_2_sv( sv_newmortal(), node->GetData() ) );

Wx_Size*
Wx_Sizer::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

Wx_Point*
Wx_Sizer::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

Wx_Size*
Wx_Sizer::GetMinSize()
  CODE:
    RETVAL = new wxSize( THIS->GetMinSize() );
  OUTPUT:
    RETVAL

void
Wx_Sizer::InsertWindow( pos, window, option = 0, flag = 0, border = 0 )
    int pos
    Wx_Window* window
    int option
    int flag
    int border
  CODE:
    THIS->Insert( pos, window, option, flag, border );

void
Wx_Sizer::InsertSizer( pos, sizer, option = 0, flag = 0, border = 0 )
    int pos
    Wx_Sizer* sizer
    int option
    int flag
    int border
  CODE:
    THIS->Insert( pos, sizer, option, flag, border );

void
Wx_Sizer::InsertSpace( pos, width, height, option = 0, flag = 0, border = 0 )
    int pos
    int width
    int height
    int option
    int flag
    int border
  CODE:
    THIS->Insert( pos, width, height, option, flag, border );

void
Wx_Sizer::Layout()

void
Wx_Sizer::PrependWindow( window, option = 0, flag = 0, border = 0 )
    Wx_Window* window
    int option
    int flag
    int border
  CODE:
    THIS->Prepend( window, option, flag, border );

void
Wx_Sizer::PrependSizer( sizer, option = 0, flag = 0, border = 0 )
    Wx_Sizer* sizer
    int option
    int flag
    int border
  CODE:
    THIS->Prepend( sizer, option, flag, border );

void
Wx_Sizer::PrependSpace( width, height, option = 0, flag = 0, border = 0 )
    int width
    int height
    int option
    int flag
    int border
  CODE:
    THIS->Prepend( width, height, option, flag, border );

void
Wx_Sizer::RecalcSizes()

bool
Wx_Sizer::RemoveWindow( window )
    Wx_Window* window
  CODE:
    RETVAL = THIS->Remove( window );
  OUTPUT:
    RETVAL

bool
Wx_Sizer::RemoveSizer( sizer )
    Wx_Sizer* sizer
  CODE:
    RETVAL = THIS->Remove( sizer );
  OUTPUT:
    RETVAL

bool
Wx_Sizer::RemoveNth( nth )
    int nth
  CODE:
    RETVAL = THIS->Remove( nth );
  OUTPUT:
    RETVAL

void
Wx_Sizer::SetDimension( x, y, width, height )
    int x
    int y
    int width
    int height

void
Wx_Sizer::SetItemMinSizeWindow( window, width, height )
    Wx_Window* window
    int width
    int height
  CODE:
    THIS->SetItemMinSize( window, width, height );

void
Wx_Sizer::SetItemMinSizeSizer( sizer, width, height )
    Wx_Sizer* sizer
    int width
    int height
  CODE:
    THIS->SetItemMinSize( sizer, width, height );

void
Wx_Sizer::SetItemMinSizeNth( pos, width, height )
    int pos
    int width
    int height
  CODE:
    THIS->SetItemMinSize( pos, width, height );

void
Wx_Sizer::SetMinSizeSize( size )
    Wx_Size size
  CODE:
    THIS->SetMinSize( size );

void
Wx_Sizer::SetMinSizeXY( x, y )
    int x
    int y
  CODE:
    THIS->SetMinSize( x, y );

void
Wx_Sizer::SetSizeHints( window )
    Wx_Window* window

MODULE=Wx PACKAGE=Wx::BoxSizer

Wx_BoxSizer*
Wx_BoxSizer::new( orientation )
    int orientation

int
Wx_BoxSizer::GetOrientation()

MODULE=Wx PACKAGE=Wx::StaticBoxSizer

Wx_StaticBoxSizer*
Wx_StaticBoxSizer::new( box, orient )
    Wx_StaticBox* box
    int orient

Wx_StaticBox*
Wx_StaticBoxSizer::GetStaticBox()

MODULE=Wx PACKAGE=Wx::NotebookSizer

Wx_NotebookSizer*
Wx_NotebookSizer::new( notebook )
    Wx_Notebook* notebook

Wx_Notebook*
Wx_NotebookSizer::GetNotebook()

MODULE=Wx PACKAGE=Wx::GridSizer

Wx_GridSizer*
Wx_GridSizer::new( rows, cols, vgap = 0, hgap = 0 )
    int rows
    int cols
    int vgap
    int hgap

MODULE=Wx PACKAGE=Wx::FlexGridSizer

Wx_FlexGridSizer*
Wx_FlexGridSizer::new( rows, cols, vgap = 0, hgap = 0 )
    int rows
    int cols
    int vgap
    int hgap
