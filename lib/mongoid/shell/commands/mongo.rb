module Mongoid
  module Shell
    module Commands
      class Mongo < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Primary
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password
        include Mongoid::Shell::Properties::AuthenticationDatabase
        include Mongoid::Shell::Properties::SSL

        arg :host_port_and_db

        option :username
        option :password, sensitive: true
        option :eval
        option :nodb
        option :norc
        option :quiet
        option :ipv6
        option :authenticationDatabase
        option :ssl

        def host_port_and_db
          [primary, db].compact.join('/')
        end
      end
    end
  end
end
