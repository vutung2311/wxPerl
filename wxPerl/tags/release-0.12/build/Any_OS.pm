package Any_OS;

use strict;
use Config;
use File::Find;
use wxMMUtils;
use Cwd;

my $exp = MM->catfile( qw(blib lib Wx _Exp.pm) );
my $ovl = MM->catfile( qw(blib lib Wx _Ovl.pm) );
my $ovlc = MM->catfile( qw(cpp ovl_const.cpp) );
my $ovlh = MM->catfile( qw(cpp ovl_const.h) );

sub constants {
  my $this = shift;

  if( $this->{PARENT} && !is_inside_wxperl_tree ) {
    my $top = top_dir;
    my $p = $this->{PARENT};

    # dmake gets Really Confused by rules like C:\foo: bar baz
    # work atound that (not really correct, but the best compromise)
    $top =~ s/^\w:// if $^O eq 'MSWin32';

    for my $k ( keys %$p ) {
      next unless $k =~ m/^INST_/;
      my $dir = $p->{$k};
      next unless $dir;

      # it's a make macro, use as it is
      if( $dir =~ m/^\$/ ) {
        $this->{$k} = $dir;
      } else {
        $this->{$k} = MM->catdir( $top, 'ext', $dir );
      }
    }

    if( $] >= 5.008 ) {
      for my $m ( keys %{$this->{PM}} ) {
        ${$this->{PM}}{$m} =~ s{.*[\\/]lib([\\/])}{\$(INST_LIB)$1};
      }
    }
  }

  package MY;
  $this->SUPER::constants( @_ );
}

sub depend {
  my $this = shift;

  my @ovl = files_with_overload();
  my %depend = ( xs_depend( $this, [ MM->curdir(), top_dir() ] ),
                 ( $this->{PARENT} ?
                   () :
                   ( $exp => join( ' ', files_with_constants() ),
                     $ovlc => 'overload', # join( ' ', @ovl, 'overload' ),
                     $ovlh => $ovlc,
                     '$(INST_STATIC)' => " $exp ",
                     '$(INST_DYNAMIC)' => " $exp ",
                   )
                 )
               );
  my %this_depend = @_;

  foreach ( keys %depend ) {
    $this_depend{$_} .= ' ' . $depend{$_};
  }

  package MY;
  $this->SUPER::depend( %this_depend );
}

#
# files that require special processing
#
sub files_with_constants {
  my @files;

  my $wanted = sub {
    my $name = $File::Find::name;

    m/\.(?:pm|xs|cpp|h)$/i && do {
      local *IN;
      my $line;

      open IN, "< $_" || warn "unable to open '$_'";
      while( defined( $line = <IN> ) ) {
        $line =~ m/^\W+\!\w+:/ && do {
          push @files, $name;
          return;
        };
      };
    };
  };

  find( $wanted, MM->curdir );

  return @files;
}

sub files_with_overload {
  my @files;

  my $wanted = sub {
    my $name = $File::Find::name;

    m/\.pm$/i && do {
      my $line;
      local *IN;

      open IN, "< $_" || warn "unable to open '$_'";
      while( defined( $line = <IN> ) ) {
        $line =~ m/Wx::_match/ && do {
          push @files, $name;
          return;
        };
      }
    };

    m/\.xs$/i && do {
      my $line;
      local *IN;

      open IN, "< $_" || warn "unable to open '$_'";
      while( defined( $line = <IN> ) ) {
        $line =~ m/wxPli_match_arguments|BEGIN_OVERLOAD\(\)/ && do {
          push @files, $name;
          return;
        };
      }
    };
  };

  find( $wanted, MM->curdir );

  return @files;
}

sub postamble {
  my $this = shift;
  my $text = '';

  unless( $this->{PARENT} ) {
    my @c_files = files_with_constants();
    my @o_files = files_with_overload();

    $text = <<EOT;

$exp :
\t\$(PERL) script/make_exp_list.pl $exp @c_files

overload :
\t\$(PERL) script/make_ovl_list.pl foo_unused $ovlc $ovlh @o_files
\t\$(TOUCH) overload

# $ovlc :
# \t\$(PERL) script/make_ovl_list.pl foo_unused $ovlc $ovlh @o_files

# $ovlh :
# \t\$(PERL) script/make_ovl_list.pl foo_unused $ovlc $ovlh @o_files

EOT
  }

  $text;
}

sub dynamic {
  my $this = shift;
  package MY;
  my $text = $this->SUPER::dynamic( @_ );

  if( $this->{PARENT} && $wxConfig::o_static ) {
    if( $text =~ m/(.*?)^(dynamic\s*:+.*?)$(.*)/ms ) {
      my( $pre, $dyn, $post ) = ( $1, $2, $3 );
      # this 'works' because $post is a no-op
      $dyn =~ s/\$\(INST_\w+\)\s*//g;
      return "$pre$dyn \$(OBJECT)$post";
    }
  } else {
    return $text;
  }
}

sub configure {
  my %config =
    ( LIBS => $wxConfig::extra_libs,
      CCFLAGS => $wxConfig::extra_cflags,
    );

  $config{INC} .= "-I" . MM->curdir . " ";
  if( building_extension() ) {
    $config{DEFINE} .= " -DWXPL_EXT ";
    $config{INC} .= " -I" . top_dir() . " ";
  } else {
    $config{clean} = { FILES => "$ovlc $ovlh .exists overload " };
  }

  if( $wxConfig::o_static ) {
    $config{DEFINE} .= " -DWXPL_STATIC ";
    if( !building_extension() ) {
      $config{LDFROM} = join( ' ',
        obj_from_src( map { glob "ext/$_/*.xs" }
                      @$wxConfig::subdirs
                    ) ) . ' ';
    }
  }

  return \%config;
}

sub get_config {
  my $this = $_[0];
  my %cfg1 = %{$_[1]};
  my %cfg2 = %{$wxConfig::Arch->configure( @_ )};
  my $cfg = merge_config( \%cfg1, \%cfg2 );

  if( $wxConfig::Verbose >= 1 ) {
    foreach (keys %$cfg) {
      m/^[A-Z]+$/ || next;
      print( $_ ," => ", $cfg->{$_}, "\n" );
    }
  }

  return $cfg;
}

# add -Ibuild (or -I../../build) to command line
sub test {
  my $this = shift;
  package MY;
  my $text = $this->SUPER::test( @_ );

  my $build = wxMMUtils::unix_top_dir() . '/build';
  $text =~ s/(\$\(FULLPERL\)\s+)/$1\"-I$build\" /g;
  $text =~ s/-Mblib\b/-Mblib=$build/g;

  return $text;
}

#
# stubs from now on
#

sub top_targets { package MY; my $x = shift; $x->SUPER::top_targets( @_ ); }
sub dynamic_lib { package MY; my $x = shift; $x->SUPER::dynamic_lib( @_ ); }
sub ppd { package MY; my $x = shift; $x->SUPER::ppd( @_ ); }

1;

__DATA__

=head NAME

Any_OS - INTERNAL, USED AT BUILD TIME

=cut

# local variables:
# mode: cperl
# end: