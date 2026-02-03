Mongoid::Shell
==============

[![Gem Version](https://badge.fury.io/rb/mongoid-shell.svg)](https://badge.fury.io/rb/mongoid-shell)
[![Test](https://github.com/mongoid/mongoid-shell/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/mongoid/mongoid-shell/actions/workflows/test.yml)
[![Rubocop](https://github.com/mongoid/mongoid-shell/actions/workflows/rubocop.yml/badge.svg?branch=master)](https://github.com/mongoid/mongoid-shell/actions/workflows/rubocop.yml)
[![Code Climate](https://codeclimate.com/github/mongoid/mongoid-shell.svg)](https://codeclimate.com/github/mongoid/mongoid-shell)

Create mongo command-lines from Mongoid configuration.

For example, connect to your production database without having to remember the entire command line using a `db:production:shell` Rake task.

``` ruby
namespace :db
  namespace :production
    task :shell
      Mongoid.load! File.join(Rails.root, "config/mongoid.yml"), :production
      system Mongoid::Shell::Commands::Mongo.new.to_s
    end
  end
end
```

Commands can be created for the current default session or you can pass a session as an argument to a new command.

``` ruby
Mongoid::Shell::Commands::Mongodump.new # will use Mongoid.default_session
Mongoid::Shell::Commands::Mongodump.new(session: Moped::Session.new([ "127.0.0.1:27017" ]))
```

Commands accept parameters.

``` ruby
out = File.join(Dir.tmpdir, 'db_backup')
mongodump = Mongoid::Shell::Commands::Mongodump.new(db: 'another_database', out: out)
system mongodump.to_s # mongodump --db another_database --out /tmp/db_backup
```

To specify parameters multiple times, set them to arrays.

``` ruby
mongodump = Mongoid::Shell::Commands::Mongodump.new(excludeCollection: %w(users products))
system mongodump.to_s # mongodump --excludeCollection users --excludeCollection products
```

To use output in logs, pass the `mask_sensitive` option to `to_s`.

``` ruby
> Mongoid::Shell::Commands::Mongo.new.to_s(mask_sensitive: true)
 => "mongo 59.1.22.1:27017/mongoid --username user --password ********"

> Mongoid::Shell::Commands::Mongo.new.to_s(mask_sensitive: '(masked)')
 => "mongo 59.1.22.1:27017/mongoid --username user --password (masked)"
```

Compatibility
-------------

This gem supports Mongoid 3, 4, 5, 6, 7, 8 and 9.

Supported Commands
------------------

### Mongo

The mongo shell is an interactive JavaScript shell for MongoDB. The `Mongoid::Shell::Commands::Mongo` class generates a command line to connect to MongoDB. A particularly useful feature is that it will always yield the address of the master node of a MongoDB replica set.

``` ruby
Mongoid::Shell::Commands::Mongo.new.to_s
```

Supports `--username`, `--password`, `--eval`, `--nodb`, `--norc`, `--quiet`, `--ipv6`, `--ssl` and `--authenticationDatabase`.

### Mongodump

Mongodump is a utility for creating a binary export of the contents of a database.

``` ruby
mongodump = Mongoid::Shell::Commands::Mongodump.new(collection: 'test')
mongodump.to_s # mongodump --db test --collection test
```

The `Mongoid::Shell::Commands::Mongodump` class supports `--db`, `--host`, `--username`, `--password`, `--query`, `--out`, `--collection`, `--excludeCollection`, `--excludeCollectionsWithPrefix`, `--directoryperdb`, `--journal`, `--oplog`, `--repair`, `--forceTableScan`, `--dbpath`, `--ipv6`, `--ssl` and `--authenticationDatabase`

### Mongorestore

The mongorestore tool imports content from binary database dump, created by mongodump into a specific database.

``` ruby
mongorestore = Mongoid::Shell::Commands::Mongorestore.new(collection: 'test', restore: '/tmp/db_backup')
mongorestore.to_s # mongorestore --db test --collection test /tmp/db_backup
```

The `Mongoid::Shell::Commands::Mongorestore` class supports `--db`, `--host`, `--username`, `--password`, `--collection`, `--ipv6`, `--dbpath`, `--directoryperdb`, `--journal`, `--objcheck`, `--filter`, `--drop`, `--oplogReplay`, `--keepIndexVersion`, `--noIndexRestore`, `--ssl` and `--authenticationDatabase`

### Mongoexport

The mongoexport tool produces a JSON or CSV export of data stored in a MongoDB instance.

``` ruby
mongoexport = Mongoid::Shell::Commands::Mongoexport.new(collection: 'traffic', out: 'traffic.json')
mongoexport.to_s # mongoexport --db test --collection traffic --out traffic.json
```

The `Mongoid::Shell::Commands::Mongoexport` class supports `--verbose`, `--quiet`, `--version`, `--port`, `--ipv6`, `--ssl`, `--sslCAFile`, `--sslPEMKeyFile`, `--sslPEMKeyPassword`, `--sslCRLFile`, `--sslAllowInvalidCertificates`, `--sslAllowInvalidHostnames`, `--sslFIPSMode`, `--authenticationDatabase`, `--authenticationMechanism`, `--gssapiServiceName`, `--gssapiHostName`, `--collection`, `--fields`, `--fieldFile`, `--query`, `--csv`, `--type`, `--out`, `--jsonArray`, `--pretty`, `--slaveOk`, `--forceTableScan`, `--skip`, `--limit`, `--sort`, `--directoryperdb`, `--journal`, `--dbpath`.

### Mongoimport

The mongoimport tool imports content from an Extended JSON, CSV, or TSV export created by mongoexport, or potentially, another third-party export tool.


``` ruby
mongoimport = Mongoid::Shell::Commands::Mongoimport.new(collection: 'contacts', file: 'contacts.json')
mongoimport.to_s # mongoimport --db test --collection contacts --file contacts.json
```

The `Mongoid::Shell::Commands::Mongoimport` class supports `--verbose`, `--quiet`, `--version`, `--host`, `--username`, `--password`, `--port`, `--ipv6`, `--ssl`, `--sslCAFile`, `--sslPEMKeyFile`, `--sslPEMKeyPassword`, `--sslCRLFile`, `--sslAllowInvalidCertificates`, `--sslAllowInvalidHostnames`, `--sslFIPSMode`, `--authenticationDatabase`, `--authenticationMechanism`, `--gssapiServiceName`, `--gssapiHostName`, `--db`, `--collection`, `--fields`, `--directoryperdb`, `--journal`, `--dbpath`, `--fieldFile`, `--ignoreBlanks`, `--type`, `--file`, `--drop`, `--headerline`, `--upsert`, `--upsertFields`, `--stopOnError`, `--jsonArray`, `--maintainInsertionOrder`, `--numInsertionWorkers`, `--writeConcern`.

### Mongostat

The mongostat utility provides a quick overview of the status of a currently running mongod or mongos instance.

The `Mongoid::Shell::Commands::Mongostat` class supports `--host`, `--username`, `--password`, `--rowcount`, `--discover`, `--noheaders`, `--http`, `--all`, `--ssl` and `--authenticationDatabase`.

Contributing
------------

Fork the project. Make your feature addition or bug fix with tests. Send a pull request. Bonus points for topic branches.

Copyright and License
---------------------

MIT License, see [LICENSE](http://github.com/mongoid/mongoid-shell/raw/master/LICENSE.md) for details.

(c) 2013-2026 [Daniel Doubrovkine](http://github.com/dblock), [Artsy Inc.](http://artsy.net)
