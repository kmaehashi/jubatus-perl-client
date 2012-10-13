package Jubatus::Recommender::Datum;

sub new {
  my ($class, $string_values, $num_values) = @_;
  my $self = {string_values => $string_values || [], num_values => $num_values || []};
  return bless $self, $class;
}

sub to_msgpack {
  my ($self) = @_;
  return [$self->{'string_values'}, $self->{'num_values'}];
}

1;
