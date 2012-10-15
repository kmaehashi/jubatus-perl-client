#!/usr/bin/perl

use strict;
use warnings;
use lib "lib";

use Jubatus::Recommender::Client;

my $NAME = "recommender_ml";

my $r = new Jubatus::Recommender::Client("127.0.0.1", 9199);

for (my $i = 0; $i < 943; $i++) {
    my $sr = $r->similar_row_from_id($NAME, $i."", 10);
    print "user ", $i, " is similar to: ";
    for (my $n = 1; $n < @$sr; $n++) {
        print $$sr[$n][0], ", ";
    }
    print "\n";
}
