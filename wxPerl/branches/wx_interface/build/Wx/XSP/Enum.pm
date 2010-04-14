package build::Wx::XSP::Enum;

use strict;
use warnings;

sub new { return bless { parser => $_[1] }, $_[0] }

sub register_plugin {
    my( $class, $parser ) = @_;

    $parser->add_post_process_plugin( plugin => $class->new( $parser ) );
}

sub post_process {
    my( $self, $nodes ) = @_;
    my $parser = $self->{parser};
    my %constants;

    foreach my $node ( @$nodes ) {
        next unless $node->isa( 'ExtUtils::XSpp::Node::Enum' );

        foreach my $val ( @{$node->elements} ) {
            next unless $val->isa( 'ExtUtils::XSpp::Node::EnumValue' );
            $constants{$val->name} ||= 1;
        }
    }

    ( my $name = File::Basename::basename( $parser->current_file ) ) =~ tr/./_/;
    my $file = "xspp/$name.h";
    my $consts = join "\n",
                  map "    r( $_ );",
                      keys %constants;

    my @lines = sprintf <<'EOT', $name, $consts, $name, $name;
#include "cpp/constants.h"

static double %s_constant( const char* name, int arg )
{
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();

//    switch( fl )
//    {
%s
//    default:
//        break;
//    }
#undef r

    WX_PL_CONSTANT_CLEANUP();
}

static wxPlConstants %s_module( &%s_constant );
EOT

    push @$nodes,
         ExtUtils::XSpp::Node::Raw->new( rows => [ qq{#include "$file"} ] ),
         ExtUtils::XSpp::Node::File->new( file => $file ),
         ExtUtils::XSpp::Node::Raw->new( rows => \@lines ),
         ExtUtils::XSpp::Node::File->new( file => '-' );
}

1;
