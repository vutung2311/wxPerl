#!/usr/bin/perl -w

# test for client data handling in various controls

use strict;
use Wx;
use lib './t';
use Tests_Helper qw(test_frame);
use Wx::Event qw(EVT_BUTTON);

package MyClass;

sub new {
  my $class = shift;
  my $code = shift;
  die "want a CODE reference" unless ref $code eq 'CODE';

  return bless [ $code ], $class;
}

sub DESTROY { &{$_[0][0]} }

package DataFrame;

use Test::More 'tests' => 45;

use strict;
use base 'Wx::Frame';
use vars '$TODO';

sub tdata($) { Wx::TreeItemData->new( MyClass->new( $_[0] ) ) }
sub cdata($) { MyClass->new( $_[0] ) }

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( undef, -1, 'Test!' );

  $this->Show(1);

  ############################################################################
  # wxTreeCtrl
  ############################################################################

  my $tree = Wx::TreeCtrl->new( $this, -1 );
  my $root = $tree->AddRoot( 'Root', -1, -1,
                             Wx::TreeItemData->new( 'Frobnicate' ) );

  my $trdata = $tree->GetItemData( $root );
  my $data = $trdata->GetData();
  is( $data, 'Frobnicate', "Wx::TreeItemData::GetData" );
  $data = $trdata->GetData();

  is( $data, 'Frobnicate', "Wx::TreeItemData::GetData (again)" );
  $data = $tree->GetPlData( $root );
  is( $data, 'Frobnicate', "Wx::TreeCtrl::GetPlData" );

  $trdata = $tree->GetItemData( $root );
  $trdata->SetData( 'Baz' );
  $trdata = $tree->GetItemData( $root );
  $data = $trdata->GetData();
  is( $data, 'Baz', "Wx::TreeItemData::SetData" );
  $tree->SetItemData( $root, Wx::TreeItemData->new( 'Boo' ) );
  $data = $tree->GetPlData( $root );
  is( $data, 'Boo', "Wx::TreeCtrl::SetItemData" );
  $tree->SetPlData( $root, 'XyZ' );
  $data = $tree->GetPlData( $root );
  is( $data, 'XyZ', "Wx::TreeCtrl::SetPlData" );

  # test deleting and setting again
  my( $deleting, $setting, $ctrldelete ) = ( 0, 0, 0 );

  my $item1 = $tree->AppendItem( $root, 'An item', -1, -1,
                                 tdata sub { $deleting = 1 } );
  my $item2 = $tree->AppendItem( $root, 'An item', -1, -1,
                                 tdata sub { $setting = 1 } );
  my $item3 = $tree->AppendItem( $root, 'An item', -1, -1,
                                 tdata sub { $ctrldelete = 1 } );

  $tree->Delete( $item1 );
  ok( $deleting, 'WxTreeCtrl: deleting an item deletes the data' );
  $tree->SetItemData( $item2, Wx::TreeItemData->new( 'foo' ) );
  ok( $setting, 'Wx::TreeCtrl: setting again item data deletes old data' );
  # and hope the tree is deleted NOW
  $tree->Destroy;
  ok( $ctrldelete, 'Wx::TreeCtrl: deleting the tree deletes the data' );

  ############################################################################
  # wxListBox & co.
  ############################################################################

  my $list = Wx::ListBox->new( $this, -1 );
  my $combo = Wx::ComboBox->new( $this, -1, 'foo' );
  my $choice = Wx::Choice->new( $this, -1 );
  my $checklist = Wx::CheckListBox->new( $this, -1 );

  # test deleting and setting again
  for my $x ( [ $list, 'Wx::ListBox' ],
              [ $choice, 'Wx::Choice' ],
              [ $combo, 'Wx::ComboBox' ],
              [ $checklist, 'Wx::CheckListBox' ], ) {
  SKIP: {
      my( $list, $name ) = @$x;
      ( $deleting, $setting, $ctrldelete ) = ( 0, 0, 0 );

      skip( "wxMSW wxCheckListBox can't store client data yet", 8 )
        if Wx::wxMSW && $name eq 'Wx::CheckListBox';
      skip( "wxGTK has bugs in versions <= 2.3.3", 8 )
        if Wx::wxGTK && Wx::wxVERSION < 2.003003 &&
           ( $name->isa( 'Wx::ListBox' ) || $name->isa( 'Wx::Choice' ) );

      # diag "starting tests for $name";
      my $data = 'Foo';

      $list->Append( 'An item', $data );
      $list->Append( 'An item' );

      $data = 'Frobnication';

      is( $list->GetClientData( 0 ), 'Foo', "$name: some client data" );
      is( $list->GetClientData( 1 ), undef, "$name: no client data" );
      $list->SetClientData( 0, 'Bar' );
      $list->SetClientData( 1, 'Baz' );
      is( $list->GetClientData( 0 ), 'Bar', "$name: setting client data" );
      is( $list->GetClientData( 1 ), 'Baz',
          "$name: setting client data (again)" );

      my $x = 1;
      $list->SetClientData( 0, \$x );
      $x = 2;
      is( ${$list->GetClientData( 0 )}, 2,
          "$name: client data is a reference" );

      $list->Append( 'An item', cdata sub { $setting = 1 } );
      $list->Append( 'An item', cdata sub { $ctrldelete = 1 } );
      $list->Append( 'An item', cdata sub { $deleting = 1 } );

      $list->Delete( 4 );
      ok( $deleting, "$name: deleting an item deletes the data" );
      $list->SetClientData( 2, 'foo' );
      ok( $setting, "$name: setting again item data deletes old data" );
      # and hope the control is deleted NOW
      $list->Destroy;
      ok( $ctrldelete, "$name: deleting the control deletes the data" );
    }
  }

  ############################################################################
  # wxListCtrl
  ############################################################################

  my $listctrl = Wx::ListCtrl->new( $this, -1, [-1, -1], [-1, -1],
                                    Wx::wxLC_REPORT() );
  $listctrl->InsertColumn( 1, "Type" );

  $listctrl->InsertStringItem( 0, 'text0' );
  $listctrl->InsertStringItem( 1, 'text1' );
  $listctrl->InsertStringItem( 2, 'text2' );

  $listctrl->SetItemData( 0, 123 );
  $listctrl->SetItemData( 1, 456 );
  $listctrl->SetItemData( 2, 789 );

  is( $listctrl->GetItemData( 0 ), 123, "Wx::ListCtrl first item data" );
  is( $listctrl->GetItemData( 1 ), 456, "Wx::ListCtrl second item data" );
  is( $listctrl->GetItemData( 2 ), 789, "Wx::ListCtrl third item data" );

  $listctrl->SetItemData( 1, 135 );

  is( $listctrl->GetItemData( 1 ), 135, "Wx::ListCtrl, changing item data" );

  $this->Destroy;

  return $this;
}

package main;

test_frame( 'DataFrame' );

# Local variables: #
# mode: cperl #
# End: #

