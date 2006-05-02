package Bot::BasicBot::Pluggable::Module::LongURLs;
use Bot::BasicBot::Pluggable::Module;
use base qw(Bot::BasicBot::Pluggable::Module);

use warnings;
use strict;

use WWW::MakeAShorterLink;

sub help {
    my ($self, $mess) = @_;
    return "I hate long URLs.";
}

sub init {
    my $self = shift;
    $self->set("user_max_length", 100) unless defined($self->get("user_max_length"));
}


sub said {
    my ($self, $mess, $pri) = @_;
    return unless ($pri == 0);

    my $body = $mess->{body};
 
    return if $mess->{body} =~ /phobos.apple.com/;   
    return unless $mess->{body} =~ m!(http://\S+)!;
    return unless length($1) > $self->get("user_max_length");
    my $long = $1;
    my $short = $long;
    
    unless ($short =~ s!a\d+.\w.akamai\w*.net/\w+/\w+/\w+/\w+/!!) {
      $short = makeashorterlink($long) or return;
    }
    return unless length($short) < length($long);
    return unless $short;
    
    $self->{Bot}->reply($mess, "urgh. long url. Try $short");

}

1;
