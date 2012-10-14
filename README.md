Jubatus Perl Client
===================

About
-----

This is a Jubatus client written in Perl. Note that this is an UNOFFICIAL release.

Requirements
------------

* Jubatus 0.3.2 (0.3.1 may also work)
* AnyEvent::MPRPC (`$ cpan AnyEvent::MPRPC`)
* Briefly tested on Mac OS X and Scientific Linux 6.

Usage
-----

* See `sample.pl` for the usage.
* I've also ported [@odasatoshi](https://github.com/odasatoshi/)'s [movielens](https://github.com/odasatoshi/movielens) example to Perl (`ml_update.pl` and `ml_analysis.pl`).
  For the usage of this example, refer to the [official blog entry](http://blog.jubat.us/2012/03/jubatus_27.html) (written in Japanese).

Limitations
-----------

* Currently limited number of RPC methods are hand-implemented.
  I'm NOT planning to implement the all of them - instead, I'm going to fix MsgPack-IDL generator for Perl to generate codes like this.
* AnyEvent::MPRPC currently cannot handle blessed Perl objects.
  Instead of calling `to_msgpack` in each client, fix MPRPC module to call it automatically, like in [msgpack-rpc-python](https://github.com/msgpack/msgpack-rpc-python).
  So far, I'm not sure it's possible or not, though.
* No unittests are currently included.

