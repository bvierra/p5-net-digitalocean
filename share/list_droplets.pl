#!/usr/bin/env perl

use FindBin;
use lib "$FindBin::Bin/../lib";

use Modern::Perl;
use Net::DigitalOcean;

my $do = Net::DigitalOcean->new(
  token => '6ff538f80616b70bb947596760de61466ad6dcdfc3be0832ae99d8f71f060005'
);

my $r = $do->droplet_list();

for (@{ $r->{content} }) {
  print "[".$_->{id}."] ".$_->{name}."\n";
}
