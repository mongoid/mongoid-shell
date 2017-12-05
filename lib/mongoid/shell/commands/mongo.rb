module Mongoid
  module Shell
    module Commands
      class Mongo < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Primary
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        attr_accessor :eval, :nodb, :norc, :quiet, :ipv6, :ssl, :authenticationDatabase

        def initialize(attrs = {})
          super
        end

        def host_port_and_db
          [primary, db].compact.join('/')
        end

        def vargs
          super({
            'db address' => :host_port_and_db,
            '--username' => :username,
            '--password' => :password,
            '--eval' => :eval,
            '--nodb' => :nodb,
            '--norc' => :norc,
            '--quiet' => :quiet,
            '--ipv6' => :ipv6,
            '--ssl' => :ssl,
            '--authenticationDatabase' => :authenticationDatabase
          })
        end
      end
    end
  end
end
