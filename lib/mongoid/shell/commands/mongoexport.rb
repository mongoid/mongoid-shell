module Mongoid
  module Shell
    module Commands
      class Mongoexport < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Host
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        attr_accessor :verbose, :quiet, :version, :port, :ipv6, :ssl, :sslCAFile,
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
          super({
            '--db' => :db,
            '--verbose' => :verbose,
            '--quiet' => :quiet,
            '--version' => :version,
            '--host' => :host,
            '--port' => :port,
            '--ipv6' => :ipv6,
            '--ssl' => :ssl,
            '--sslCAFile' => :sslCAFile,
            '--sslPEMKeyFile' => :sslPEMKeyFile,
            '--sslPEMKeyPassword' => :sslPEMKeyPassword,
            '--sslCRLFile' => :sslCRLFile,
            '--sslAllowInvalidCertificates' => :sslAllowInvalidCertificates,
            '--sslAllowInvalidHostnames' => :sslAllowInvalidHostnames,
            '--sslFIPSMode' => :sslFIPSMode,
            '--username' => :username,
            '--password' => :password,
            '--authenticationDatabase' => :authenticationDatabase,
            '--authenticationMechanism' => :authenticationMechanism,
            '--gssapiServiceName' => :gssapiServiceName,
            '--gssapiHostName' => :gssapiHostName,
            '--collection' => :collection,
            '--fields' => :fields,
            '--fieldFile' => :fieldFile,
            '--query' => :query,
            '--type' => :type,
            '--out' => :out,
            '--jsonArray' => :jsonArray,
            '--pretty' => :pretty,
            '--slaveOk' => :slaveOk,
            '--forceTableScan' => :forceTableScan,
            '--skip' => :skip,
            '--limit' => :limit,
            '--sort' => :sort,
            '--csv' => :csv, # is deprecated from Mongo version 3.0.0, use type instead
            '--directoryperdb' => :directoryperdb, # is deprecated from Mongo version 3.0.0
            '--journal' => :journal, # is deprecated from Mongo version 3.0.0
            '--dbpath' => :dbpath # is deprecated from Mongo version 3.0.0
          })
        end
      end
    end
  end
end
