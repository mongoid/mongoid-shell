module Mongoid
  module Shell
    module Commands
      class Mongostat < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Host
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password
        include Mongoid::Shell::Properties::AuthenticationDatabase
        include Mongoid::Shell::Properties::SSL

        option :host
        option :username
        option :password, sensitive: true
        option :rowcount
        option :discover
        option :noheaders
        option :http
        option :all
        option :authenticationDatabase
        option :ssl
      end
    end
  end
end
