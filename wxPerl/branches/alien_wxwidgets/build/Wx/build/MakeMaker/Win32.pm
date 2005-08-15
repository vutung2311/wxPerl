package Wx::build::MakeMaker::Win32;

use strict;
use base 'Wx::build::MakeMaker::Any_OS';
use Wx::build::Utils;
use File::Basename ();

sub configure_core {
  my $this = shift;
  my %config = $this->SUPER::configure_core( @_ );

  my $res = $this->_res_file;
  $config{depend}      = { $res => 'Wx.rc ' };
  $config{LDFROM}     .= "\$(OBJECT) $res ";
  $config{dynamic_lib}{INST_DYNAMIC_DEP} .= " $res";
  $config{clean}{FILES} .= " $res Wx_def.old";

  return %config;
}

sub configure_ext {
  my $this = shift;
  my $is_tree = Wx::build::MakeMaker::is_wxPerl_tree();
  my %config = $this->SUPER::configure_ext( @_ );

  return %config;
}

sub postamble_core {
  my $this = shift;
  my $wxdir = Alien::wxWidgets->wx_base_directory;
  my $text = $this->SUPER::postamble_core( @_ );
  my $command = $this->_res_command;
  my $res_file = $this->_res_file;

  $command =~ s/%incdir/$wxdir\\include/;
  $command =~ s/%src/Wx.rc/;
  $command =~ s/%dest/$res_file/;
  my $strip = $this->_strip_command;

  $text .= sprintf <<'EOT', $res_file, $command, $strip;

%s : Wx.rc
	%s

# for compatibility
ppmdist : ppm

ppm : pure_all
%s
	perl script/make_ppm.pl

EOT
}

1;

# local variables:
# mode: cperl
# end:
