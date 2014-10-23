module Mongoid
  module Shell
    module Commands
      class Mongoimport < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Host
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        attr_accessor :version, :collection, :fields, :fieldFile, :jsonArray, :directoryperdb,
          :journal, :dbpath, :ipv6, :ignoreBlanks, :type, :file, :drop, :headerline, :upsert,
          :upsertFields, :stopOnError

        def initialize(attrs = {})
          super
        end

        def vargs
          super({
            '--host' => :host,
            '--db' => :db,
            '--username' => :username,
            '--password' => :password,
            '--version' => :version,
            '--collection' => :collection,
            '--fields' => :fields,
            '--fieldFile' => :fieldFile,
            '--jsonArray' => :jsonArray,
            '--directoryperdb' => :directoryperdb,
            '--journal' => :journal,
            '--dbpath' => :dbpath,
            '--ipv6' => :ipv6,
            '--ignoreBlanks' => :ignoreBlanks,
            '--type' => :type,
            '--file' => :file,
            '--drop' => :drop,
            '--headerline' => :headerline,
            '--upsert' => :upsert,
            '--upsertFields' => :upsertFields,
            '--stopOnError' => :stopOnError
          })
        end
      end
    end
  end
end
