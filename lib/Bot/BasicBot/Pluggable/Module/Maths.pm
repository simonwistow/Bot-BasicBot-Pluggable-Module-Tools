package Bot::BasicBot::Pluggable::Module::Maths;

use strict;
use Bot::BasicBot::Pluggable::Module; 
use base qw(Bot::BasicBot::Pluggable::Module);

use Math::Expression;



sub said { 
    my ($self, $mess, $pri) = @_;

    my $body = $mess->{body}; 
    my $who  = $mess->{who};

    return unless ($pri == 3);

    my $calc = Math::Expression->new;

    $calc->SetOpt( PrintErrFunc => sub { } );

    my $tree;
    eval {
        $tree = $calc->Parse($body) || return;
    };
    return if $@;
    return $calc->EvalToScalar($tree);

}

sub help {
    return "Commands: a maths expression";
}

1;

=head1 NAME

Bot::BasicBot::Pluggable::Module::Maths - evaluate arbitary maths expressions

=head1 SYNOPSIS

Does everything that C<Math::Expression> does;

=head1 AUTHOR

Simon Wistow, <simon@thegestalt.org>


=head1 COPYRIGHT

Copyright 2005, Simon Wistow

Distributed under the same terms as Perl itself.

=head1 SEE ALSO

L<Math::Expression>

=cut 

