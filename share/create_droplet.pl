#!/usr/bin/env perl

use FindBin;
use lib "$FindBin::Bin/../lib";

use Modern::Perl;
use Net::DigitalOcean;

my $do = Net::DigitalOcean->new(
  token => 'test'
);

$do->droplet_create({
  name    => 'Test',
  region  => 'nyc3'
  });
