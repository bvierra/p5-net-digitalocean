package Net::DigitalOcean::Role::Droplets;


use Modern::Perl;
use Moo::Role;
use utf8;

requires 'make_request';

# VERSION

sub droplet_create {
  my ($self,$opts) = @_;

  print "droplet_create\n";
  print "REF: ".ref($opts)."\n";
  use Data::Dumper;
  print Dumper $opts;

}

sub droplet_list {
  my ($self) = @_;
  return $self->make_request(GET => '/droplets');
}

1;
