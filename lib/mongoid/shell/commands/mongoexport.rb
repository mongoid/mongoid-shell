module Mongoid
  module Shell
    module Commands
      class Mongoexport < Mongoid::Shell::Commands::Base
        include Mongoid::Shell::Properties::Host
        include Mongoid::Shell::Properties::Database
        include Mongoid::Shell::Properties::Username
        include Mongoid::Shell::Properties::Password

        attr_accessor :version, :collection, :fields, :fieldFile, :query, :csv, :out, :jsonArray,
          :directoryperdb, :journal, :forceTableScan, :limit, :sort, :dbpath, :ipv6

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
            '--query' => :query,
            '--csv' => :csv,
            '--out' => :out,
            '--jsonArray' => :jsonArray,
            '--directoryperdb' => :directoryperdb,
            '--journal' => :journal,
            '--forceTableScan' => :forceTableScan,
            '--limit' => :limit,
            '--sort' => :sort,
            '--dbpath' => :dbpath,
            '--ipv6' => :ipv6
          })
        end
      end
    end
  end
end
