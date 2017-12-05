module Mongoid
  module Shell
    module Commands
      class Mongoexport < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Host
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password
        include Mongoid::Shell::Properties::AuthenticationDatabase
        include Mongoid::Shell::Properties::SSL

        # args
        option :db
        option :host
        option :port
        option :sslCAFile
        option :sslPEMKeyFile
        option :sslPEMKeyPassword, sensitive: true
        option :sslCRLFile
        option :username
        option :password, sensitive: true
        option :authenticationDatabase
        option :authenticationMechanism
        option :collection
        option :fields
        option :fieldFile
        option :query
        option :type
        option :out
        option :skip
        option :limit
        option :sort

        # boolean options
        option :verbose
        option :quiet
        option :ipv6
        option :ssl
        option :sslAllowInvalidCertificates
        option :sslAllowInvalidHostnames
        option :sslFIPSMode
        option :gssapiServiceName
        option :gssapiHostName
        option :jsonArray
        option :pretty
        option :slaveOk
        option :forceTableScan

        # is deprecated from Mongo version 3.0.0, use type instead
        option :csv

        # these 3 below are deprecated from Mongo version 3.0.0
        option :directoryperdb
        option :journal
        option :dbpath
      end
    end
  end
end
