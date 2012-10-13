package Jubatus::Recommender::Datum;

sub new {
  my ($class) = @_;
  my $self = {string_values => [], num_values => []};
  return bless $self, $class;
}

sub to_msgpack {
  my ($self) = @_;
  return [$self->{'string_values'}, $self->{'num_values'}];
}

sub from_msgpack {
  my ($class, $ref) = @_;
  my $datum = new Jubatus::Recommender::Datum();
  $datum->{'string_values'} = $$ref[0];
  $datum->{'num_values'} = $$ref[1];
  return $datum;
}

1;
