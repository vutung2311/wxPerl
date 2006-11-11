#############################################################################
## Name:        XS/TextCtrl.xs
## Purpose:     XS for Wx::TextCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: TextCtrl.xs,v 1.24 2006/11/11 15:03:06 mbarbon Exp $
## Copyright:   (c) 2000-2003, 2005-2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

%module{Wx};

%{
#include <wx/textctrl.h>
%}

%typemap{wxMouseEvent&}{reference};
%typemap{wxTextAttr*}{simple};
%typemap{const wxTextAttr&}{reference};
%typemap{wxTextAttrAlignment}{simple};
%typemap{const wxKeyEvent&}{reference};
%typemap{wxTextPos}{parsed}{%wxTextPos%};

%name{Wx::TextUrlEvent} class wxTextUrlEvent
{
    wxMouseEvent& GetMouseEvent();
    long GetURLStart();
    long GetURLEnd();
};

%name{Wx::TextAttr} class wxTextAttr
{
    ## ctor in plain XS
    ## // thread KO
    ~wxTextAttr();

#if WXPERL_W_VERSION_GE( 2, 7, 0 )
    void Merge( const wxTextAttr& overlay );
#endif
    void SetTextColour( const wxColour& colText );
    void SetBackgroundColour( const wxColour& colBack );
    void SetFont( const wxFont& font, long flags = wxTEXT_ATTR_FONT );
    void SetAlignment( wxTextAttrAlignment alignment );
    void SetTabs( const wxArrayInt& tabs );
    void SetLeftIndent( int indent, int subIndent = 0 );
    void SetRightIndent( int indent );
    void SetFlags( long flags );

    bool HasTextColour() const;
    bool HasBackgroundColour() const;
    bool HasFont() const;
    bool HasAlignment() const;
    bool HasTabs() const;
    bool HasLeftIndent() const;
    bool HasRightIndent() const;
    bool HasFlag( long flag ) const;

    const wxColour& GetTextColour() const;
    const wxColour& GetBackgroundColour() const;
    const wxFont& GetFont() const;
    wxTextAttrAlignment GetAlignment() const;
##    const wxArrayInt& GetTabs() const;
    long GetLeftIndent() const;
    long GetLeftSubIndent() const;
    long GetRightIndent() const;
    long GetFlags() const;
    bool IsDefault() const;
};

%{

wxTextAttr*
wxTextAttr::new( colText = wxNullColour, colBack = wxNullColour, font = (wxFont*)&wxNullFont )
    wxColour colText
    wxColour colBack
    wxFont* font
  CODE:
    if( items == 1 )
        RETVAL = new wxTextAttr();
    else
        RETVAL = new wxTextAttr( colText, colBack, *font );
  OUTPUT:
    RETVAL

%}

%name{Wx::TextCtrlBase} class wxTextCtrlBase
{
    wxString GetValue() const;
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
    bool IsEmpty();
#endif
    void SetValue( const wxString& value );
#if WXPERL_W_VERSION_GE( 2, 7, 1 )
    void ChangeValue( const wxString& value );
#endif
    wxString GetRange( long from, long to ) const;
    int GetLineLength( long lineNo ) const;
    wxString GetLineText( long lineNo ) const;
    int GetNumberOfLines() const;
    bool IsModified() const;
    bool IsEditable() const;
    bool IsSingleLine() const;
    bool IsMultiLine() const;
    wxString GetStringSelection() const;
    void Clear();
    void Replace( long from, long to, const wxString& value );
    void Remove( long from, long to );
#if WXPERL_W_VERSION_GE( 2, 7, 1 )
    bool LoadFile( const wxString& file, int fileType = wxTEXT_TYPE_ANY );
    bool SaveFile( const wxString& file = wxEmptyString,
                   int fileType = wxTEXT_TYPE_ANY );
#else
    bool LoadFile( const wxString& file );
    bool SaveFile( const wxString& file = wxEmptyString );
#endif
    void MarkDirty();
    void DiscardEdits();
#if WXPERL_W_VERSION_GE( 2, 7, 0 )
    void SetModified( bool modified );
#endif
    void SetMaxLength( unsigned long len );
    void WriteText( const wxString& text );
    void AppendText( const wxString& text );
    bool EmulateKeyPress( const wxKeyEvent& event );
    bool SetStyle( long start, long end, const wxTextAttr& style );
##    bool GetStyle( long position, wxTextAttr& style );
    bool SetDefaultStyle( const wxTextAttr& style );
    const wxTextAttr& GetDefaultStyle() const;
    long XYToPosition( long x, long y ) const;
    void ShowPosition(long pos);
    void Copy();
    void Cut();
    void Paste();
    bool CanCopy() const;
    bool CanCut() const;
    bool CanPaste() const;
    void Undo();
    void Redo();
    bool CanUndo() const;
    bool CanRedo() const;
    void SetInsertionPoint( long pos );
    void SetInsertionPointEnd();
    long GetInsertionPoint() const;
    wxTextPos GetLastPosition() const;
    void SetSelection( long from, long to );
    void SelectAll();
    void SetEditable( bool editable );
};

%{

void
wxTextCtrlBase::GetSelection()
  PREINIT:
    long from;
    long to;
  PPCODE:
    THIS->GetSelection( &from, &to );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( from ) ) );
    PUSHs( sv_2mortal( newSViv( to ) ) );

void
wxTextCtrlBase::PositionToXY( pos )
    long pos
  PREINIT:
    long x;
    long y;
  PPCODE:
    THIS->PositionToXY( pos, &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

void
wxTextCtrlBase::HitTest( pt )
    wxPoint pt
  PPCODE:
    long col, row;
    wxTextCtrlHitTestResult res = THIS->HitTest( pt, &col, &row );

    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( res ) ) );
    PUSHs( sv_2mortal( newSViv( col ) ) );
    PUSHs( sv_2mortal( newSViv( row ) ) );

%}

%{
MODULE=Wx PACKAGE=Wx::TextCtrl

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::TextCtrl::new" )

wxTextCtrl*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxTextCtrl();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxTextCtrl*
newFull( CLASS, parent, id, value, pos = wxDefaultPosition, size = wxDefaultSize, style = 0 , validator = (wxValidator*)&wxDefaultValidator, name = wxTextCtrlNameStr )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxString value
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxTextCtrl( parent, id, value, pos, size,
                             style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxTextCtrl::Create( parent, id, value, pos = wxDefaultPosition, size = wxDefaultSize, style = 0 , validator = (wxValidator*)&wxDefaultValidator, name = wxTextCtrlNameStr )
    wxWindow* parent
    wxWindowID id
    wxString value
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  C_ARGS: parent, id, value, pos, size, style, *validator, name

%}