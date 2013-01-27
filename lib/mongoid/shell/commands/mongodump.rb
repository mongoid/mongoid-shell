module Mongoid
  module Shell
    module Commands
      class Mongodump < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Host
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        attr_accessor :collection, :query

        def initialize(attrs = {})
          super
        end

        def vargs
          super({
            '--host' => :host,
            '--db' => :database_name,
            '--username' => :username,
            '--password' => :password,
            '--collection' => :collection,
            '--query' => :query
          })
        end

      end
    end
  end
end