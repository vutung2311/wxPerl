#!/usr/bin/perl -w

BEGIN { print "1..2\n"; }

use strict;
use Wx;
use lib 'build';
use Tests_Helper qw(test_app);

my $frame;
my $app = test_app( sub {
                      $frame = new MyFrame( undef, -1, 'boo' );
                      $frame->Show( 1 );
                      return 1;
                    } );

# test with Notify

package MyTimer;

use vars qw(@ISA); @ISA = qw(Wx::Timer);

sub Notify {
  print "ok 1\n";
}

package main;

my $timer1 = MyTimer->new;
$timer1->Start( 100, 1 );

# test with owner

package MyHandler;

use base qw(Wx::EvtHandler);
use Wx::Event qw(EVT_TIMER);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( @_ );

  EVT_TIMER( $this, -1, \&OnTimer );

  return $this;
}

#wxTheApp->ExitMainLoop;

sub OnTimer {
  print "ok 2\n";
  Wx::WakeUpIdle;
  $frame->Destroy;
}

package MyFrame;

use base qw(Wx::Frame);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( @_ );

  my $timer2 = Wx::Timer->new( MyHandler->new );
  $timer2->Start( 400, 1 );

  return $this;
}

package main;

$app->MainLoop;

# Local variables: #
# mode: cperl #
# End: #

