package Wx::build::MakeMaker::Core::Dummy;

# to avoid W::b::MM clobbering our wxWriteMakefile

use Wx::build::MakeMaker;

package Wx::build::MakeMaker::Core;

use strict;
use ExtUtils::MakeMaker;
use Wx::build::Utils qw(obj_from_src c_from_xs);
use Wx::build::Options;
use File::Path 'mkpath';
use File::Basename qw(basename);
use base 'Exporter';
use vars qw(@EXPORT @subdirs);

@EXPORT = 'wxWriteMakefile';

my @top_level_xs = qw(Wx.xs Constant.xs Controls.xs Event.xs
                      Frames.xs GDI.xs Window.xs);
our @module_xs = qw(XS/Bitmap.xs XS/Mask.xs XS/Button.xs XS/BitmapButton.xs
                    XS/ListCtrl.xs XS/Image.xs XS/TreeCtrl.xs XS/RadioBox.xs
                    XS/Log.xs XS/Notebook.xs XS/Config.xs XS/ToolBar.xs
                    XS/Locale.xs XS/Region.xs XS/Caret.xs);
our @module_xsp = qw(XS/ComboCtrl.xsp XS/ComboPopup.xsp XS/ComboBox.xsp
                     XS/OwnerDrawnComboBox.xsp XS/TextAttr.xsp XS/TextCtrl.xsp
                     XS/ArtProvider.xsp XS/VScrolledWindow.xsp XS/DC.xsp
                     XS/MimeTypes.xsp XS/Display.xsp XS/ClassInfo.xsp
                     XS/SplitterWindow.xsp);
@subdirs = qw(socket dnd filesys grid help html mdi print xrc stc docview
              calendar datetime media richtext aui dataview);
my %subdirs;

Wx::build::MakeMaker::_set_is_wxPerl_tree( 1 );
eval { require Alien::wxWidgets };
our $has_alien = $@ ? 0 : 1;
my %options = Wx::build::Options->get_makemaker_options if $has_alien;

if( $has_alien ) {
  @subdirs{@subdirs} = (1) x @subdirs;
  my %opt = %{$options{subdirs}};

  @subdirs{keys %opt} = values %opt;

  @subdirs = grep { $subdirs{$_} } keys %subdirs;
}

#
# make symlinks to the source tree
#
if( $options{mksymlinks} ) {
  require FindBin;
  require ExtUtils::Manifest;
  require File::Spec::Functions;

  local *catfile = \&File::Spec::Functions::catfile;
  local *splitpath = \&File::Spec::Functions::splitpath;

  my $manifest = MM->catfile( $FindBin::RealBin, 'MANIFEST' );
  die "Can't find MANIFEST" unless -e $manifest;
  my $files = ExtUtils::Manifest::maniread( $manifest );

  foreach my $f ( keys %$files ) {
    my( $fr, $to ) = ( catfile( $FindBin::RealBin, $f ), $f );
    my $dir;
    ( undef, $dir, undef ) = splitpath( $to );
    mkpath( $dir ) if length $dir && !-d $dir;
    next if -l $to;
    if( -e $to ){ unlink $to or die "unlink '$to' failed: $!" }
    symlink( $fr, $to ) or die "symlink '$fr' => '$to' failed: $!";
  }
}

#
# write cpp/setup.h
#
if( $has_alien ) {
  unless( -d 'cpp' ) {
    mkpath( 'cpp' ) or die "mkpath 'cpp': $!";
  }

  local *OUT;
  open OUT, "> cpp/setup.h" or die "open 'cpp/setup.h': $!";

  print OUT <<EOT;
//
// GENERATED BY Makefile.PL, DO NOT EDIT
//

#ifndef __CPP_SETUP_H__
#define __CPP_SETUP_H__

EOT

  foreach my $o ( sort keys %subdirs ) {
    print OUT "#define wxPERL_USE_", uc $o, " ", $subdirs{$o} ,"\n";
  }

  print OUT <<EOT;

#endif // __CPP_SETUP_H__
EOT

  close OUT;
}

Wx::build::Options->write_config_file( 'Opt' ) if $has_alien;

#
# WriteMakefile wrapper
#
sub wxWriteMakefile {
  my %params = @_;
  local $Wx::build::MakeMaker::is_core = 1;

  if( $has_alien ) {
      $params{XSOPT}     = ' -nolinenumbers -noprototypes ';
      $params{CONFIGURE} = \&Wx::build::MakeMaker::configure;
      $params{OBJECT}    = join ' ', obj_from_src( @top_level_xs ),
                                     obj_from_src( map basename( $_ ), @module_xs, @module_xsp ), '';
  }

  my $build = Wx::build::MakeMaker::_process_mm_arguments( \%params, $has_alien );

  if( $build ) {
    WriteMakefile( %params );
    unless( Alien::wxWidgets->can( 'load' ) ) {
        print <<EOT;
======================================================================
Alien::wxWidgets is missing, you will need to re-run Makefile.PL after
it is installed.
======================================================================
EOT
        sleep 3;
        open my $fh, ">> alien_wxwidgets_missing";
        print $fh "touched";
    }
  } else {
    ExtUtils::MakeMaker::WriteEmptyMakefile( %params );
  }
}

1;

# local variables:
# mode: cperl
# end:
