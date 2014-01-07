Mongoid::Shell [![Build Status](https://travis-ci.org/dblock/mongoid-shell.png?branch=mongoid-2x)](https://travis-ci.org/dblock/mongoid-shell)
==============

This branch supports Mongoid 2.x, 3.x and 4.x.

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

Supported Commands
------------------

### Mongo

The mongo shell is an interactive JavaScript shell for MongoDB. The `Mongoid::Shell::Commands::Mongo` class generates a command line to connect to MongoDB. A particularly useful feature is that it will always yield the address of the master node of a MongoDB replica set.

``` ruby
Mongoid::Shell::Commands::Mongo.new.to_s
```

Supports `--username`, `--password`, `--eval`, `--nodb`, `--norc`, `--quiet` and `--ipv6`.

### Mongodump

Mongodump is a utility for creating a binary export of the contents of a database.

``` ruby
mongodump = Mongoid::Shell::Commands::Mongodump.new({ collection: 'test' })
mongodump.to_s # mongodump --db test --collection test
```

The `Mongoid::Shell::Commands::Mongodump` class supports `--db`, `--host`, `--username`, `--password`, `--query`, `--out`, `--collection`, `--directoryperdb`, `--journal`, `--oplog`, `--repair`, `--forceTableScan`, `--dbpath` and `--ipv6`.

### Mongorestore

The mongorestore tool imports content from binary database dump, created by mongodump into a specific database.

``` ruby
mongorestore = Mongoid::Shell::Commands::Mongorestore.new({ collection: 'test', restore: '/tmp/db_backup' })
mongorestore.to_s # mongorestore --db test --collection test /tmp/db_backup
```

The `Mongoid::Shell::Commands::Mongorestore` class supports `--db`, `--host`, `--username`, `--password`, `--collection`, `--ipv6`, `--dbpath`, `--directoryperdb`, `--journal`, `--objcheck`, `--filter`, `--drop`, `--oplogReplay`, `--keepIndexVersion` and `--noIndexRestore`.

### Mongostat

The mongostat utility provides a quick overview of the status of a currently running mongod or mongos instance.

The `Mongoid::Shell::Commands::Mongostat` class supports `--host`, `--username`, `--password`, `--rowcount`, `--discover`, `--noheaders`, `--http` and `--all`.

Contributing
------------

Fork the project. Make your feature addition or bug fix with tests. Send a pull request. Bonus points for topic branches.

Copyright and License
---------------------

MIT License, see [LICENSE](http://github.com/dblock/mongoid-shell/raw/master/LICENSE.md) for details.

(c) 2013 [Daniel Doubrovkine](http://github.com/dblock), [Artsy Inc.](http://artsy.net)


