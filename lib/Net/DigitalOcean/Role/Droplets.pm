package Net::DigitalOcean::Role::Droplets;


use Modern::Perl;
use Moo::Role;
use utf8;

requires 'make_request';

# VERSION

sub droplet_create {
  my ($self,$opts) = @_;

  return { status_code => "428", status_line => "428 HTTP_PRECONDITION_REQUIRED (RETURNED FROM Net::DigitalOcean::Role::Droplets - missing required option)" }
    if (!$opts->{name} || !$opts->{region} || !$opts->{size} || !$opts->{image});

  return $self->make_requtest(POST => '/droplets', $opts);
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

sub droplet_get {
  my ($self, $id) = @_;
  $id = int($id);

  return { status_code => "428", status_line => "428 HTTP_PRECONDITION_REQUIRED (RETURNED FROM Net::DigitalOcean::Role::Droplets - missing Droplet ID to get)" }
    if !$id;

  return $self->make_request(GET => "/droplets/$id");
}

1;
