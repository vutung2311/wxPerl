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
    my( %constants, %conditions );

    foreach my $node ( @$nodes ) {
        next unless $node->isa( 'ExtUtils::XSpp::Node::Enum' );

        $conditions{$node->condition} ||= 1 if $node->condition;
        foreach my $val ( @{$node->elements} ) {
            next unless $val->isa( 'ExtUtils::XSpp::Node::EnumValue' );
            $constants{$val->name} ||= [ $val->condition ];
            $conditions{$val->condition} ||= 1 if $val->condition;
        }
    }

    ( my $name = File::Basename::basename( $parser->current_file ) ) =~ tr/./_/;
    my $file = "xspp/$name.h";
    my @defines;
    while( my( $k, $v ) = each %constants ) {
        if( $v->[0] ) {
            push @defines, "#ifdef $v->[0]",
                           "    r( $k );",
                           "#endif",
        } else {
            push @defines, "    r( $k );",
        }
    }
    my $consts = join "\n", @defines;
    my $all_conditions = join ' && ', 1,
                         map "defined( $_ )",
                             keys %conditions;
    my @lines = sprintf <<'EOT', $all_conditions, $name, $consts, $name, $name;
#if %s

#include "cpp/constants.h"

static double %s_constant( const char* name, int arg )
{
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();

    // !package: Wx
    // !tag:
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }

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

#endif
EOT

    push @$nodes,
         ExtUtils::XSpp::Node::Raw->new( rows => [ qq{#include "$file"} ] ),
         ExtUtils::XSpp::Node::File->new( file => $file ),
         ExtUtils::XSpp::Node::Raw->new( rows => \@lines ),
         ExtUtils::XSpp::Node::File->new( file => '-' );
}

1;
