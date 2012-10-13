package Jubatus::Recommender::Client;

use AnyEvent::MPRPC::Client;

sub new {
  my ($class, $host, $port) = @_;
  my $client = AnyEvent::MPRPC::Client->new(host => $host, port => $port);
  bless { client => $client }, $class;
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

sub complete_row_from_data {
  my ($self, $name, $dat) = @_;
  return Jubatus::Recommender::Datum->from_msgpack(
    $self->{'client'}->call(complete_row_from_data => [
      $name, $dat->to_msgpack()
    ])->recv);
}

sub similar_row_from_data {
  my ($self, $name, $data, $size) = @_;
  return $self->{'client'}->call(similar_row_from_data => [
    $name, $data->to_msgpack(), $size
  ])->recv;
}

sub decode_row {
  my ($self, $name, $id) = @_;
  return Jubatus::Recommender::Datum->from_msgpack(
    $self->{'client'}->call(decode_row => [
      $name, $name, $id
    ])->recv);
}

sub get_all_rows {
  my ($self, $name) = @_;
  return $self->{'client'}->call(get_all_rows => [
    $name
  ])->recv;
}

sub l2norm {
  my ($self, $name, $d) = @_;
  return $self->{'client'}->call(l2norm => [
    $name, $d->to_msgpack()
  ])->recv;
}

1;
