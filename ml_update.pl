#!/usr/bin/perl -Ilib/

use strict;
use warnings;
use utf8;
use Fcntl;

use Jubatus::Recommender::Client;
use Jubatus::Recommender::ConfigData;
use Jubatus::Recommender::Datum;

my $NAME = "recommender_ml";

my $r = new Jubatus::Recommender::Client("127.0.0.1", 9199);

my $converter = get_converter();

my $config = new Jubatus::Recommender::ConfigData("lsh", $converter);
$r->set_config($NAME, $config);

sysopen (my $fh, "./dat/ml-100k/u.data", O_RDONLY) || die "cannot open data file";

my $d = new Jubatus::Recommender::Datum([], []);
my $n = 0;
while (<$fh>) {
    my ($userid, $movieid, $rating, $mtime) = split;
    my $num_values = [];
    if ($n % 1000 == 0) {
        print $n, "\n";
    }
    push @$num_values, [$movieid, $rating/1.0]; # convert $rating into double
    $d->{num_values} = $num_values;
    $r->update_row($NAME, $userid, $d);
    $n++;
}
close $fh;


sub get_converter { local $/; return <DATA>; }

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
