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

1;
