package build::Wx::Virtual::XSP;

use strict;
use warnings;

sub new {
    return bless { virtual_methods => {},
                   virtual_classes => {},
                   }, $_[0];
}

sub register_plugin {
    my( $class, $parser ) = @_;
    my $instance = $class->new;

    $parser->add_method_tag_plugin( $instance );
    $parser->add_post_process_plugin( $instance );
}

sub handle_method_tag {
    my( $self, $method, $tag, %args ) = @_;

    $self->{virtual_methods}{$method} = $method;

    1;
}

my %type_map =
  ( 'bool'             => { convert_return => 'SvTRUE( ret )',
                            default_value  => 'false',
                            type_char      => 'b',
                            },
    'int'              => { convert_return => 'SvIV( ret )',
                            default_value  => '0',
                            type_char      => 'i',
                            },
    'unsigned int'     => { convert_return => 'SvUV( ret )',
                            default_value  => '0',
                            type_char      => 'I',
                            },
    'wxString'         => { convert_return => 'wxPli_sv_2_wxString( aTHX_ ret )',
                            default_value  => 'wxEmptyString',
                            type_char      => 'P',
                            arguments      => '&%s',
                            },
    'wxVariant&'       => { convert_return => 'wxPli_sv_2_variant( aTHX_ ret )',
                            default_value  => 'wxVariant()',
                            type_char      => 'q',
                            arguments      => '&%s, "Wx::Variant"',
                            },
    'const wxVariant&' => { convert_return => 'wxPli_sv_2_variant( aTHX_ ret )',
                            default_value  => 'wxVariant()',
                            type_char      => 'q',
                            arguments      => '&%s, "Wx::Variant"',
                            },
    );

sub _virtual_typemap {
    my( $type ) = @_;
    my $tm = $type_map{$type->print};

    die "No virtual typemap for ", $type->print unless $tm;

    return $tm;
}

sub post_process {
    my( $self, $nodes ) = @_;

    my @copy = @$nodes;

    foreach my $node ( @copy ) {
        next unless $node->isa( 'ExtUtils::XSpp::Node::Class' );
        next if $self->{virtual_classes}{$node};
        my @virtual;

        foreach my $method ( @{$node->methods} ) {
            next unless $self->{virtual_methods}{$method};

            push @virtual, $method;
        }

        next unless @virtual;

        # TODO wxPerl-specific
        ( my $cpp_class = $node->cpp_name ) =~ s/^wx/wxPl/;
        ( my $perl_class = $cpp_class ) =~ s/^wx/Wx::/;
        my $file = lc "cpp/$cpp_class.h";

        unshift @$nodes,
                ExtUtils::XSpp::Node::Raw->new
                    ( rows => [ "#include \"$file\"" ] );

        # for abstract class, delete all constructors
        my @constructors = grep $_->isa( 'ExtUtils::XSpp::Node::Constructor' ),
                                @{$node->methods};
        my @cpp_code;
        $node->delete_methods( @constructors );

        push @cpp_code, sprintf <<EOC,
class %s : public %s
{
    // TODO wxPerl-specific
    WXPLI_DECLARE_V_CBACK();
public:
EOC
          $cpp_class, $node->cpp_name;

        my @new_constructors;
        foreach my $constructor ( @constructors ) {
            my $cpp_parms = join ', ', map $_->name, @{$constructor->arguments};
            my $cpp_args = join ', ', map $_->print, @{$constructor->arguments};

            push @cpp_code, sprintf <<EOC,
    %s( const char* CLASS, %s )
        : %s( %s ),
          m_callback( "%s" )
    {
        m_callback.SetSelf( wxPli_make_object( this, CLASS ), true );
    }
EOC
              $cpp_class, $cpp_args, $node->cpp_name, $cpp_parms, $perl_class;

            my $code = [ "RETVAL = new $cpp_class( CLASS, $cpp_parms );" ];

            my $new_ctor = ExtUtils::XSpp::Node::Constructor->new
                               ( cpp_name   => $cpp_class,
                                 code       => $code,
                                 arguments  => $constructor->arguments,
                                 );

            push @new_constructors, $new_ctor;
        }

        foreach my $method ( @virtual ) {
            my( @cpp_parms, @arg_types );
            foreach my $arg ( @{$method->arguments} ) {
                my $typemap = _virtual_typemap( $arg->type );
                my $format = $typemap->{arguments} || '%s';

                push @cpp_parms, sprintf $format, $arg->name;
                push @arg_types, $typemap->{type_char};
            }

            my( $cpp_parms, $arg_types );
            if( @cpp_parms ) {
                $cpp_parms = join ', ', @cpp_parms;
                $arg_types = '"' . join( '', @arg_types ) . '", ';
            } else {
                $cpp_parms = '';
                $arg_types = 'NULL';
            }

            push @cpp_code, '    ' . $method->print_declaration;
            my $call_base = $node->cpp_name . '::' . $method->cpp_name .
              '(' . $cpp_parms . ')';
            if( $method->ret_type->is_void ) {
                # TODO only pure methods for now
                my $default = 'return';
                push @cpp_code, sprintf <<EOT,
    // TODO wxPerl-specific
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "%s" ) )
        {
            wxPliCCback( aTHX_ &m_callback, G_SCALAR|G_DISCARD,
                         %s %s );
        }
        else
            %s;
    }
EOT
                  $method->cpp_name, $arg_types, $cpp_parms, $default;
            } else {
                my $ret_type_map = _virtual_typemap( $method->ret_type );

                # TODO only pure for now
                my $default = $ret_type_map->{default_value};
                my $convert = $ret_type_map->{convert_return};
                push @cpp_code, sprintf <<EOT,
    // TODO wxPerl-specific
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "%s" ) )
        {
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,
                                             %s %s ) );
            return %s;
        }
        else
            return %s;
    }
EOT
                  $method->cpp_name, $arg_types, $cpp_parms, $convert, $default;
            }
        }

        push @cpp_code, '};', '';

        open my $h_file, '>', $file;
        print $h_file join "\n", @cpp_code;
        close $h_file;

        my $new_class = ExtUtils::XSpp::Node::Class->new
                            ( cpp_name     => $cpp_class,
                              perl_name    => $perl_class,
                              base_classes => [ $node ],
                              methods      => \@new_constructors,
                              );

        push @$nodes, $new_class;
    }
}

1;
