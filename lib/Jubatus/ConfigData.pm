package Jubatus::ConfigData;

sub new {
  my ($class, $method, $converter) = @_;
  my $self = {method => $method, converter => $converter};
  return bless $self, $class;
}

sub to_msgpack {
  my ($self) = @_;
  return [$self->{'method'}, $self->{'converter'}];
}

1;
