Jubatus Perl Client
===================

About
-----

This is a Jubatus client written in Perl. Note that this is an UNOFFICIAL release.

Requirements
------------

* Jubatus 0.3.2
* AnyEvent::MPRPC (`$ cpan install AnyEvent::MPRPC`)
* Only tested on Mac OS X :)

Usage
-----

See `sample.pl` for the usage.

Limitations
-----------

* Currently limited number of functions are hand-implemented.
  I'm NOT planning to implement the all of them - instead, I'm going to fix MsgPack-IDL generator for Perl to generate codes like this.
* AnyEvent::MPRPC currently cannot handle blessed Perl objects.
  Instead of calling `to_msgpack` in each client, fix MPRPC to call it automatically, like in msgpack-rpc-python.
  So far, I'm not sure it's possible or not, though.

