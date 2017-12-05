module Mongoid
  module Shell
    module Commands
      class Mongostat < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Host
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        attr_accessor :rowcount, :discover, :all, :http, :noheaders, :ssl, :authenticationDatabase

        def initialize(attrs = {})
          super
        end

        def vargs
          super({
            '--host' => :host,
            '--username' => :username,
            '--password' => :password,
            '--rowcount' => :rowcount,
            '--discover' => :discover,
            '--noheaders' => :noheaders,
            '--http' => :http,
            '--all' => :all,
            '--ssl' => :ssl,
            '--authenticationDatabase' => :authenticationDatabase
          })
        end
      end
    end
  end
end
