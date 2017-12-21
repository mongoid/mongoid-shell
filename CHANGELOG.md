### 0.4.7 (Next)

* Your contribution here.

### 0.4.6 (12/29/2017)

* [#16](https://github.com/mongoid/mongoid-shell/pull/16): Add `--ssl` and `--authenticationDatabase` support to all commands - [@cavvia](https://github.com/cavvia).

### 0.4.5 (9/7/2017)

* [#13](https://github.com/mongoid/mongoid-shell/issues/13): Support masking sensitive values with `to_s(mask_sensitive: true)` - [@dblock](https://github.com/dblock).
* [#14](https://github.com/mongoid/mongoid-shell/pull/14): Refactored arg definitions into `arg` and `option` - [@dblock](https://github.com/dblock).

### 0.4.4 (6/4/2017)

* [#11](https://github.com/mongoid/mongoid-shell/pull/11): Compatibility with Mongoid 6 - [@jbach](https://github.com/jbach).
* [#12](https://github.com/mongoid/mongoid-shell/pull/12): Added Danger, PR linter - [@dblock](https://github.com/dblock).

### 0.4.3 (6/1/2016)

* [#9](https://github.com/mongoid/mongoid-shell/pull/9): Remove example and spec alleging that `--collection` can be specified multiple times - [@joeyAghion](https://github.com/joeyAghion).

### 0.4.2 (2/9/2015)

* [#8](https://github.com/mongoid/mongoid-shell/pull/8): Support repeatable parameters; add `excludeCollection` and `excludeCollectionsWithPrefix` to `mongodump` - [@joeyAghion](https://github.com/joeyAghion).

### 0.4.1 (10/25/2015)

* [#7](https://github.com/mongoid/mongoid-shell/pull/7): Added support for `mongoimport` and `mongoexport` - [@hoang1417](https://github.com/hoang1417).

### 0.4.0 (10/20/2015)

* [#6](https://github.com/mongoid/mongoid-shell/pull/6): Compatibility with Mongoid 5.x - [@dblock](https://github.com/dblock).

### 0.3.0 (7/1/2014)

* [#3](https://github.com/mongoid/mongoid-shell/pull/3): Added Mongoid 4.x support - [@pawelniewie](https://github.com/pawelniewie), [@dblock](https://github.com/dblock).
* [#2](https://github.com/mongoid/mongoid-shell/pull/2): Added support for `--noIndexRestore` to `Mongoid::Shell::Commands::Mongorestore` - [@macreery](https://github.com/macreery).
* [#1](https://github.com/mongoid/mongoid-shell/pull/1): Enforced compatibility with Mongoid 3.x only - [@macreery](https://github.com/macreery).
* Fix: the `mongorestore` command requires a primary node in a replica set - [@dblock](https://github.com/dblock).
* Added Rubocop, Ruby style linter - [@dblock](https://github.com/dblock).
* Upgraded to RSpec 3.x expectation syntax - [@dblock](https://github.com/dblock).

### 0.2.0 (1/29/2013)

* Added `Mongoid::Shell::Commands::Mongo` that generates a command line which connects to the session's primary node - [@dblock](https://github.com/dblock).
* Added `Mongoid::Shell::Commands::Mongostat` that generates a command line for `mongostat` - [@dblock](https://github.com/dblock).
* Added `Mongoid::Shell::Commands::Mongorestore` that generates a command line for `mongorestore` - [@dblock](https://github.com/dblock).
* A `Mongoid::Shell::Errors::SessionNotConnectedError` error will be raised when a session is not connected - [@dblock](https://github.com/dblock).
* Added support for `--out`, `--dbpath`, `--directoryperdb`, `--journal`, `--oplog`, `--repair`, `--forceTableScan`, `--dbpath`, `--ipv6` to `Mongoid::Shell::Commands::Mongodump` - [@dblock](https://github.com/dblock).
* Added support for `--nodb`, `--norc`, `--quiet` and `--ipv6` to `Mongoid::Shell::Commands::Mongo` - [@dblock](https://github.com/dblock).
* It's now possible to override built-in `db`, `username`, `password`, `host` and `primary` - [@dblock](https://github.com/dblock).

### 0.1.0 (1/27/2013)

* Initial public release with support for `mongodump` - [@dblock](https://github.com/dblock).
