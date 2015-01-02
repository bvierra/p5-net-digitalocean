#!/usr/bin/env perl

use Test::More;

use Modern::Perl;
use utf8;

require_ok( 'Net::DigitalOcean' );

my $do = Net::DigitalOcean->new( 
  token => 'FakenTokenHere'
);

ok( defined $do,                  'new() returned something' );
ok( $do->isa('Net::DigitalOcean'), " and it's the right class" );

my @droplet_methods = qw/
  droplet_create
  droplet_list
  droplet_delete
/;

for (
    @droplet_methods
  )
{
  ok( $do->can($_), '$do can ' . $_ );
}

done_testing;
1;
