#!/usr/bin/perl -Ilib/

use strict;
use warnings;
use utf8;

use Jubatus::ConfigData;
use Jubatus::Recommender::Client;
use Jubatus::Recommender::Datum;

my $name = "test";
my $client = new Jubatus::Recommender::Client("127.0.0.1", 9199);
my $config = new Jubatus::ConfigData("lsh", get_converter());

$client->set_config($name, $config);

my $datum = new Jubatus::Recommender::Datum();
my @datum_nv;

# update: user1
@datum_nv = ();
push (@datum_nv, ["movie1", 1.7]);
push (@datum_nv, ["movie2", 4.9]);
$datum->{'num_values'} = \@datum_nv;
$client->update_row($name, "user1", $datum);

# update: user2
@datum_nv = ();
push (@datum_nv, ["movie1", 5.0]);
push (@datum_nv, ["movie2", 3.1]);
$datum->{'num_values'} = \@datum_nv;
$client->update_row($name, "user2", $datum);

# analyze: user3
@datum_nv = ();
push (@datum_nv, ["movie1", 4.9]);
$datum->{'num_values'} = \@datum_nv;
my $result_ref = $client->similar_row_from_data($name, $datum, 2);
my @result = @$result_ref;

foreach my $ref (@result) {
    my @elem = @$ref;
    print "result: " . $elem[0] . " = " . $elem[1] . "\n";
}

sub get_converter {
    local $/;
    return <DATA>;
}
__DATA__
{
  "string_filter_types": {},
  "string_filter_rules": [],
  "num_filter_types": {},
  "num_filter_rules": [],
  "string_types": {},
  "string_rules": [],
  "num_types": {},
  "num_rules": [{"key" : "*", "type" : "num"}]
}
