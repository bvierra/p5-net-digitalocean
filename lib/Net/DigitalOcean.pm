package Net::DigitalOcean;

use DateTime;
use JSON ();
use LWP::UserAgent;
use Modern::Perl;
use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use utf8;

with 'Net::DigitalOcean::Role::UserAgent';
with 'Net::DigitalOcean::Role::Droplets';

# ABSTRACT: Net::Digest allows you to interact with DigitalOcean's API v2 (using an API Token)

has api_base_url => (
  is      => 'ro',
  isa     => Str,
  default => sub { 'https://api.digitalocean.com/v2' }
);

has token => (
  is        => 'ro',
  isa       => Str,
  required  => 1
);

1;
