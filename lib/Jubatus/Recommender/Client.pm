package Jubatus::Recommender::Client;

use strict;
use warnings;
use AnyEvent::MPRPC::Client;

sub new {
  my ($self, $host, $port) = @_;
  my $client = AnyEvent::MPRPC::Client->new(host => $host, port => $port);
  bless { client => $client }, $self;
}

sub set_config {
  my ($self, $name, $c) = @_;
  return $self->{'client'}->call(set_config => [
    $name, $c->to_msgpack()
  ])->recv;
}

sub update_row {
  my ($self, $name, $id, $d) = @_;
  return $self->{'client'}->call(update_row => [
    $name, $id, $d->to_msgpack()
  ])->recv;
}

sub similar_row_from_data {
  my ($self, $name, $data, $size) = @_;
  return $self->{'client'}->call(similar_row_from_data => [
    $name, $data->to_msgpack(), $size
  ])->recv;
}

1;
