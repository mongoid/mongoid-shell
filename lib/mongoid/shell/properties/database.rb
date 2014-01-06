module Mongoid
  module Shell
    module Properties
      module Database
        attr_accessor :db

        # current database name
        def db
          @db || session.send(:current_database).name
        end
      end
    end
  end
end
