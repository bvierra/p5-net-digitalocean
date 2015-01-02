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

sub droplet_delete {
  my ($self, $id) = @_;
  $id = int($id);

  return { status_code => "428", status_line => "428 HTTP_PRECONDITION_REQUIRED (RETURNED FROM Net::DigitalOcean::Role::Droplets - missing Droplet ID to delete)" }
    if !$id;

  return $self->make_request(DELETE => "/droplets/$id");
}

1;
