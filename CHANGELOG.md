Next Release
============

* [#2](https://github.com/dblock/mongoid-shell/pull/2): Added support for `--noIndexRestore` to `Mongoid::Shell::Commands::Mongorestore` - [@macreery](https://github.com/macreery).
* [#1](https://github.com/dblock/mongoid-shell/pull/1): Enforced compatibility with Mongoid 3.x only - [@macreery](https://github.com/macreery).
* Your contribution here.

0.2.0 (1/29/2013)
=================

* Added `Mongoid::Shell::Commands::Mongo` that generates a command line which connects to the session's primary node - [@dblock](https://github.com/dblock).
* Added `Mongoid::Shell::Commands::Mongostat` that generates a command line for `mongostat` - [@dblock](https://github.com/dblock).
* Added `Mongoid::Shell::Commands::Mongorestore` that generates a command line for `mongorestore` - [@dblock](https://github.com/dblock).
* A `Mongoid::Shell::Errors::SessionNotConnectedError` error will be raised when a session is not connected - [@dblock](https://github.com/dblock).
* Added support for `--out`, `--dbpath`, `--directoryperdb`, `--journal`, `--oplog`, `--repair`, `--forceTableScan`, `--dbpath`, `--ipv6` to `Mongoid::Shell::Commands::Mongodump` - [@dblock](https://github.com/dblock).
* Added support for `--nodb`, `--norc`, `--quiet` and `--ipv6` to `Mongoid::Shell::Commands::Mongo` - [@dblock](https://github.com/dblock).
* It's now possible to override built-in `db`, `username`, `password`, `host` and `primary` - [@dblock](https://github.com/dblock).

0.1.0 (1/27/2013)
==================

* Initial public release with support for `mongodump` - [@dblock](https://github.com/dblock).
