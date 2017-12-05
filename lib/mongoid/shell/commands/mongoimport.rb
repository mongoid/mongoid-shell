module Mongoid
  module Shell
    module Commands
      class Mongoimport < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Host
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        attr_accessor :verbose, :quiet, :port, :ipv6, :ssl, :sslCAFile,
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
            '--username' => :username, '--password' => :password,
            '--authenticationDatabase' => :authenticationDatabase,
            '--authenticationMechanism' => :authenticationMechanism,
            '--collection' => :collection, '--fields' => :fields,
            '--fieldFile' => :fieldFile, '--type' => :type, '--file' => :file,
            '--upsertFields' => :upsertFields,
            '--maintainInsertionOrder' => :maintainInsertionOrder,
            '--numInsertionWorkers' => :numInsertionWorkers,
            '--writeConcern' => :writeConcern,
            # these 3 below are deprecated from Mongo version 3.0.0
            '--directoryperdb' => :directoryperdb,
            '--journal' => :journal, '--dbpath' => :dbpath
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
            '--ignoreBlanks' => :ignoreBlanks, '--drop' => :drop,
            '--headerline' => :headerline, '--upsert' => :upsert,
            '--stopOnError' => :stopOnError, '--jsonArray' => :jsonArray
          }
        end
      end
    end
  end
end
