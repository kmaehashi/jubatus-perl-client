package Jubatus::Recommender::Client;

use AnyEvent::MPRPC::Client;

use Jubatus::Recommender::Datum;

sub new {
  my ($class, $host, $port) = @_;
  my $client = AnyEvent::MPRPC::Client->new(host => $host, port => $port);
  bless { client => $client }, $class;
}

sub set_config {
  my ($self, $name, $c) = @_;
  my $res = $self->{'client'}->call(set_config => [
      $name, $c->to_msgpack()
    ])->recv;
  return $res;
}

sub update_row {
  my ($self, $name, $id, $d) = @_;
  my $res = $self->{'client'}->call(update_row => [
      $name, $id, $d->to_msgpack()
    ])->recv;
  return $res;
}

sub complete_row_from_data {
  my ($self, $name, $dat) = @_;
  my $res = $self->{'client'}->call(complete_row_from_data => [
      $name, $dat->to_msgpack()
    ])->recv;
  return new Jubatus::Recommender::Datum(@$res);
}

sub similar_row_from_data {
  my ($self, $name, $data, $size) = @_;
  my $res = $self->{'client'}->call(similar_row_from_data => [
      $name, $data->to_msgpack(), $size
    ])->recv;
  return $res;
}

sub decode_row {
  my ($self, $name, $id) = @_;
  my $res = $self->{'client'}->call(decode_row => [
      $name, $name, $id
    ])->recv;
  return new Jubatus::Recommender::Datum(@$res);
}

sub get_all_rows {
  my ($self, $name) = @_;
  my $res = $self->{'client'}->call(get_all_rows => [
      $name
    ])->recv;
  return $res;
}

sub l2norm {
  my ($self, $name, $d) = @_;
  my $res = $self->{'client'}->call(l2norm => [
    $name, $d->to_msgpack()
  ])->recv;
  return $res;
}

1;
