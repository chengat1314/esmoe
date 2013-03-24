use v5.16;
package Esmoe::Results;
use Moo;
use Method::Signatures;

has results => (
    is => "ro",
    required => 1
);

method print {
    my $res = $self->results;

    if ( ref($res) ne 'HASH' ) {
        die;
    }

    if ( exists $res->{hits} ) {
        say "$res->{hits}{total} hits in total..." if $res->{hits}{total} > @{ $res->{hits}{hits} };

        for (@{ $res->{hits}{hits} }) {
            my $x = $_->{_source};
            say "$_->{_id} : $x->{title}";
            for (@{$x->{heteronyms}[0]{definitions}}) {
                say "    - $_->{def}";
            }
        }
    }
    elsif (exists($res->{_source})) {
        require YAML;
        print YAML::Dump($res->{_source});
    }
}

1;
