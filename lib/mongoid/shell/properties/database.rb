# frozen_string_literal: true

module Mongoid
  module Shell
    module Properties
      module Database
        attr_accessor :db

        # current database name
        if ::Mongoid::Compatibility::Version.mongoid3? || ::Mongoid::Compatibility::Version.mongoid4?
          def db
            @db || session.send(:current_database).name
          end
        else
          def db
            @db || session.database.name
          end
        end
      end
    end
  end
end
