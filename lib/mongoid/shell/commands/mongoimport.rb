module Mongoid
  module Shell
    module Commands
      class Mongoimport < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Host
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        attr_accessor :verbose, :quiet, :version, :port, :ipv6, :ssl, :sslCAFile,
          :sslPEMKeyFile, :sslPEMKeyPassword, :sslCRLFile,
          :sslAllowInvalidCertificates, :sslAllowInvalidHostnames, :sslFIPSMode,
          :authenticationDatabase, :authenticationMechanism, :gssapiServiceName,
          :gssapiHostName, :collection, :fields, :directoryperdb, :journal, :dbpath,
          :fieldFile, :ignoreBlanks, :type, :file, :drop, :headerline, :upsert,
          :upsertFields, :stopOnError, :jsonArray, :maintainInsertionOrder,
          :numInsertionWorkers, :writeConcern

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
            '--directoryperdb' => :directoryperdb, # is deprecated from Mongo version 3.0.0
            '--journal' => :journal, # is deprecated from Mongo version 3.0.0
            '--dbpath' => :dbpath, # is deprecated from Mongo version 3.0.0
            '--fieldFile' => :fieldFile,
            '--ignoreBlanks' => :ignoreBlanks,
            '--type' => :type,
            '--file' => :file,
            '--drop' => :drop,
            '--headerline' => :headerline,
            '--upsert' => :upsert,
            '--upsertFields' => :upsertFields,
            '--stopOnError' => :stopOnError,
            '--jsonArray' => :jsonArray,
            '--maintainInsertionOrder' => :maintainInsertionOrder,
            '--numInsertionWorkers' => :numInsertionWorkers,
            '--writeConcern' => :writeConcern
          })
        end
      end
    end
  end
end
