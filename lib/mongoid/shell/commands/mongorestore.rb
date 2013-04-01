module Mongoid
  module Shell
    module Commands
      class Mongorestore < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Host
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        attr_accessor :collection, :ipv6, :dbpath, :directoryperdb, :journal, :objcheck, :filter, :drop, :oplogReplay, :keepIndexVersion, :noIndexRestore, :restore

        def initialize(attrs = {})
          super
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
            'directory or filename to restore from' => :restore
          })
        end

      end
    end
  end
end
