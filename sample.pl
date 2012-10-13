#!/usr/bin/perl -Ilib/

use strict;
use warnings;
use utf8;

use Data::Dumper;

use Jubatus::Recommender::Client;
use Jubatus::Recommender::ConfigData;
use Jubatus::Recommender::Datum;

my ($name, $host, $port) = ("test", "127.0.0.1", 9199);
my $client = new Jubatus::Recommender::Client($host, $port);
my $config = new Jubatus::Recommender::ConfigData("lsh", get_converter());

$client->set_config($name, $config);

my $datum = new Jubatus::Recommender::Datum();
my $datum_nv;

# update_row: user1
$datum_nv = [];
push @$datum_nv, ["movie1", 1.7];
push @$datum_nv, ["movie2", 4.9];
$datum->{'num_values'} = $datum_nv;
$client->update_row($name, "user1", $datum);

print "-- update_row(user1) --\n";
print Dumper($datum) . "\n";

# update_row: user2
$datum_nv = [];
push @$datum_nv, ["movie1", 5.0];
push @$datum_nv, ["movie2", 3.1];
$datum->{'num_values'} = $datum_nv;
$client->update_row($name, "user2", $datum);

print "-- update_row(user2) --\n";
print Dumper($datum) . "\n";

# similar_row_from_data: user3
$datum_nv = [];
push @$datum_nv, ["movie1", 4.9];
$datum->{'num_values'} = $datum_nv;
my $result_user3 = $client->similar_row_from_data($name, $datum, 2);

print "-- similar_row_from_data(user3) --\n";
print Dumper($datum);
foreach my $ref (@$result_user3) {
    my @elem = @$ref;
    print "recommended user: " . $elem[0] . " (similarity: " . $elem[1] . ")\n";
}
print "\n";

# complete_row_from_data: user3
$datum_nv = [];
push @$datum_nv, ["movie1", 1.7];
$datum->{'num_values'} = $datum_nv;
my $result_completed = $client->complete_row_from_data($name, $datum);

print "-- complete_row_from_data --\n";
print Dumper($datum) . "\n";
print Dumper($result_completed) . "\n";

# l2norm
$datum_nv = [];
push @$datum_nv, ["movie1", 3.0];
push @$datum_nv, ["movie2", 5.0];
$datum->{'num_values'} = $datum_nv;
my $result_l2norm = $client->l2norm($name, $datum);
print "-- l2norm --\n";
print Dumper($datum);
print "l2norm = " . $result_l2norm . "\n\n";

# decode_row: user2
my $result_decode_ref = $client->decode_row($name, "user2");

print "-- decode_row(user2) --\n";
print Dumper($result_decode_ref) . "\n";

# get_all_rows
my $all_rows = $client->get_all_rows($name);

print "-- get_all_rows --\n";
print Dumper($all_rows) . "\n";

sub get_converter { local $/; return <DATA>; }

__DATA__
{
  "string_filter_types": {},
  "string_filter_rules": [],
  "num_filter_types": {},
  "num_filter_rules": [],
  "string_types": {},
  "string_rules": [{"key": "*", "type" : "str", "sample_weight": "bin", "global_weight" : "bin"}],
  "num_types": {},
  "num_rules": [{"key" : "*", "type" : "num"}]
}
