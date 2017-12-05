module Mongoid
  module Shell
    module Commands
      class Mongorestore < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Primary
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        attr_accessor :host, :collection, :ipv6, :dbpath, :directoryperdb, :journal, :objcheck, :filter, :drop, :oplogReplay, :keepIndexVersion, :noIndexRestore, :restore, :ssl, :authenticationDatabase

        def initialize(attrs = {})
          super
        end

        def host
          @host || primary
        end

        def vargs
          super({
            '--host' => :host,
            '--db' => :db,
            '--username' => :username,
            '--password' => :password,
            '--collection' => :collection,
            '--ipv6' => :ipv6,
            '--dbpath' => :dbpath,
            '--directoryperdb' => :directoryperdb,
            '--journal' => :journal,
            '--objcheck' => :objcheck,
            '--filter' => :filter,
            '--drop' => :drop,
            '--oplogReplay' => :oplogReplay,
            '--keepIndexVersion' => :keepIndexVersion,
            '--noIndexRestore' => :noIndexRestore,
            '--ssl' => :ssl,
            '--authenticationDatabase' => :authenticationDatabase,
            'directory or filename to restore from' => :restore
          })
        end
      end
    end
  end
end
