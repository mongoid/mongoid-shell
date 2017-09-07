module Mongoid
  module Shell
    module Commands
      class Mongorestore < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Primary
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        option :host
        option :db
        option :username
        option :password
        option :collection
        option :ipv6
        option :dbpath
        option :directoryperdb
        option :journal
        option :objcheck
        option :filter
        option :drop
        option :oplogReplay
        option :keepIndexVersion
        option :noIndexRestore

        arg :restore

        def host
          @host || primary
        end
      end
    end
  end
end
