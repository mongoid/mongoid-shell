0.4.1 (Next)
============

* Your contribution here.

0.4.0 (10/20/2015)
==================

* [#6](https://github.com/dblock/mongoid-shell/pull/6) - Compatibility with Mongoid 5.x - [@dblock](https://github.com/dblock).

0.3.0 (7/1/2014)
================

* [#3](https://github.com/dblock/mongoid-shell/pull/3): Added Mongoid 4.x support - [@pawelniewie](https://github.com/pawelniewie), [@dblock](https://github.com/dblock).
* [#2](https://github.com/dblock/mongoid-shell/pull/2): Added support for `--noIndexRestore` to `Mongoid::Shell::Commands::Mongorestore` - [@macreery](https://github.com/macreery).
* [#1](https://github.com/dblock/mongoid-shell/pull/1): Enforced compatibility with Mongoid 3.x only - [@macreery](https://github.com/macreery).
* Fix: the `mongorestore` command requires a primary node in a replica set - [@dblock](https://github.com/dblock).
* Added Rubocop, Ruby style linter - [@dblock](https://github.com/dblock).
* Upgraded to RSpec 3.x expectation syntax - [@dblock](https://github.com/dblock).

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
