module Mongoid
  module Shell
    module Commands
      class Mongo < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Primary
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        arg :host_port_and_db

        option :username
        option :password
        option :eval
        option :nodb
        option :norc
        option :quiet
        option :ipv6

        def host_port_and_db
          [primary, db].compact.join('/')
        end
      end
    end
  end
end
