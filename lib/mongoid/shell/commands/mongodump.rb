module Mongoid
  module Shell
    module Commands
      class Mongodump < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Host
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password
        include Mongoid::Shell::Properties::AuthenticationDatabase
        include Mongoid::Shell::Properties::SSL

        option :host
        option :db
        option :username
        option :password, sensitive: true
        option :collection
        option :excludeCollection
        option :excludeCollectionsWithPrefix
        option :query
        option :out
        option :directoryperdb
        option :journal
        option :oplog
        option :repair
        option :forceTableScan
        option :dbpath
        option :ipv6
        option :authenticationDatabase
        option :ssl
      end
    end
  end
end
