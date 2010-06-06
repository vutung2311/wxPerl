package build::Wx::XSP::Event;

use strict;
use warnings;

sub new { return bless { parser => $_[1], events => [] }, $_[0] }

sub register_plugin {
    my( $class, $parser ) = @_;
    my $plugin = $class->new( $parser );

    $parser->add_toplevel_tag_plugin( plugin => $plugin );
    $parser->add_post_process_plugin( plugin => $plugin );
}

sub handle_toplevel_tag {
    my( $self, undef, $tag, %args ) = @_;
    my( $evt, $const ) = ( $args{any_positional_arguments}[0][0],
                           $args{any_positional_arguments}[1][0] );
    my( $name, $args ) = $evt =~ /^(\w+)\((.*)\)$/ or die $evt;
    my @args = split /\s*,\s*/, $args;

    push @{$self->{events}}, [ $name, 1 + @args, $const ];
}

sub post_process {
    my( $self, $nodes ) = @_;
    my $parser = $self->{parser};
    my @events;

    foreach my $e ( @{$self->{events}} ) {
        my( $name, $args, $const ) = @$e;

        if( !$const ) {
            push @events, "    wxPli_StdEvent( $name, $args )";
        } else {
            push @events, "    wxPli_Event( $name, $args, $const )";
        }
    }

    ( my $name = File::Basename::basename( $parser->current_file ) ) =~ tr/./_/;
    my $file = "xspp/evt_$name.h";
    my $evts = join "\n", @events;
    my $all_conditions = 1;
#     my $all_conditions = join ' && ', 1,
#                          map "defined( $_ )",
#                              keys %conditions;
    my @lines = sprintf <<'EOT', $all_conditions, $name, $evts;
#if %s

// !package: Wx::Event
// !tag:
// !parser: sub { $_[0] =~ m<^\s*wxPli_(?:Std)?Event\(\s*(\w+)\s*\,> }

#include "cpp/helpers.h"

static wxPliEventDescription %s_events[] =
{
%s
    { 0, 0, 0 }
};

#endif
EOT

    push @$nodes,
         ExtUtils::XSpp::Node::Raw->new( rows => [ qq{#include "$file"} ] ),
         ExtUtils::XSpp::Node::File->new( file => $file ),
         ExtUtils::XSpp::Node::Raw->new( rows => \@lines ),
         ExtUtils::XSpp::Node::File->new( file => '-' ),
         ExtUtils::XSpp::Node::Raw->new( rows => [ 'BOOT:', "    wxPli_set_events( ${name}_events );" ] )
         ;
}

1;
