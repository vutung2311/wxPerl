package Any_OS;

use strict;
use Config;
use File::Find;
use wxMMUtils;

sub depend {
  my $this = shift;
  my $exp = MM->catfile( qw(blib lib Wx _Exp.pm) );
  my $ovl = MM->catfile( qw(blib lib Wx _Ovl.pm) );

  my %depend = ( xs_depend( $this, [ MM->curdir(), top_dir() ] ),
                 ( $this->{PARENT} ?
                   () :
                   ( $exp => join( ' ', files_with_constants() ),
                     $ovl => join( ' ', files_with_overload() ),
                     '$(INST_STATIC)' => " $exp $ovl ",
                     '$(INST_DYNAMIC)' => " $exp $ovl ",
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

    m/\.(?:pm)$/i && do {
      my $line;
      local *IN;

      open IN, "< $_" || warn "unable to open '$_'";
      while( defined( $line = <IN> ) ) {
        $line =~ m/Wx::_match/ && do {
          push @files, $name;
          return;
        };
      };
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

    my $exp = MM->catfile( qw(blib lib Wx _Exp.pm) );
    my $ovl = MM->catfile( qw(blib lib Wx _Ovl.pm) );

    $text = <<EOT;

$exp :
\t\$(PERL) script/make_exp_list.pl $exp @c_files

$ovl :
\t\$(PERL) script/make_ovl_list.pl $ovl @o_files

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

#
# stubs from now on
#

sub top_targets { package MY; my $x = shift; $x->SUPER::top_targets( @_ ); }
sub dynamic_lib { package MY; my $x = shift; $x->SUPER::dynamic_lib( @_ ); }
sub ppd { package MY; my $x = shift; $x->SUPER::ppd( @_ ); }

1;

# Local variables: #
# mode: cperl #
# End: #
