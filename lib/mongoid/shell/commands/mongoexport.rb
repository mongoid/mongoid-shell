module Mongoid
  module Shell
    module Commands
      class Mongoexport < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Host
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        attr_accessor :verbose, :quiet, :port, :ipv6, :ssl, :sslCAFile,
                      :sslPEMKeyFile, :sslPEMKeyPassword, :sslCRLFile,
                      :sslAllowInvalidCertificates, :sslAllowInvalidHostnames, :sslFIPSMode,
                      :authenticationDatabase, :authenticationMechanism, :gssapiServiceName,
                      :gssapiHostName, :collection, :fields, :fieldFile, :query, :csv,
                      :type, :out, :jsonArray, :pretty, :slaveOk, :forceTableScan, :skip,
                      :limit, :sort, :directoryperdb, :journal, :dbpath

        def initialize(attrs = {})
          super
        end

        def vargs
          super var_options.merge(boolean_options)
        end

        private

        def var_options
          {
            '--db' => :db, '--host' => :host, '--port' => :port,
            '--sslCAFile' => :sslCAFile,
            '--sslPEMKeyFile' => :sslPEMKeyFile,
            '--sslPEMKeyPassword' => :sslPEMKeyPassword,
            '--sslCRLFile' => :sslCRLFile,
            '--username' => :username,
            '--password' => :password,
            '--authenticationDatabase' => :authenticationDatabase,
            '--authenticationMechanism' => :authenticationMechanism,
            '--collection' => :collection,
            '--fields' => :fields, '--fieldFile' => :fieldFile,
            '--query' => :query,
            '--type' => :type, '--out' => :out,
            '--skip' => :skip, '--limit' => :limit, '--sort' => :sort
          }
        end

        def boolean_options
          {
            '--verbose' => :verbose, '--quiet' => :quiet,
            '--ipv6' => :ipv6, '--ssl' => :ssl,
            '--sslAllowInvalidCertificates' => :sslAllowInvalidCertificates,
            '--sslAllowInvalidHostnames' => :sslAllowInvalidHostnames,
            '--sslFIPSMode' => :sslFIPSMode,
            '--gssapiServiceName' => :gssapiServiceName,
            '--gssapiHostName' => :gssapiHostName,
            '--jsonArray' => :jsonArray,
            '--pretty' => :pretty,
            '--slaveOk' => :slaveOk,
            '--forceTableScan' => :forceTableScan,
            '--csv' => :csv, # is deprecated from Mongo version 3.0.0, use type instead
            # these 3 below are deprecated from Mongo version 3.0.0
            '--directoryperdb' => :directoryperdb,
            '--journal' => :journal, '--dbpath' => :dbpath
          }
        end
      end
    end
  end
end
