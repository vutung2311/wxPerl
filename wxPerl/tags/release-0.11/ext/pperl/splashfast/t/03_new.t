#!/usr/bin/perl -w

use lib '../../../build';
use Test::More 'tests' => 2;

use Wx::Perl::SplashFast;

BEGIN {
  my $splash = Wx::Perl::SplashFast->new( '../../../demo/data/logo.jpg', 400 );
  isa_ok( $splash, 'Wx::SplashScreen' );
}

use Wx 'wxTheApp';

ok( 1, "compilation OK" );

Wx::WakeUpIdle();
wxTheApp->MainLoop();

# local variables:
# mode: cperl
# end:
