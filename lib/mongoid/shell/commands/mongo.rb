module Mongoid
  module Shell
    module Commands
      class Mongo < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Primary
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        attr_accessor :eval

        def initialize(attrs = {})
          super
        end

        def host_port_and_db
          [ primary, database_name ].compact.join("/")
        end

        def vargs
          super({
            'db address' => :host_port_and_db,
            '--username' => :username,
            '--password' => :password,
            '--eval' => :eval
          })
        end

      end
    end
  end
end
