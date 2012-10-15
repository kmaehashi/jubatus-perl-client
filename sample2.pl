#!/usr/bin/perl -Ilib/

use strict;
use warnings;

use Data::Dumper;

use Jubatus::Recommender::Client;

my ($name, $host, $port) = ("test", "127.0.0.1", 9199);
my $client = new Jubatus::Recommender::Client($host, $port);

my $result;

$result = $client->get_status("test");
print Dumper($result);

$result = $client->save("test", "model");
print Dumper($result);
