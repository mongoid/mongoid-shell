module Mongoid
  module Shell
    module Properties
      module Database
        attr_accessor :db

        # current database name
        def db
          @db || begin
            if Mongoid::Shell.mongoid2?
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless session && session.connection && session.connection.db
              session.connection.db.name
            else
              session.send(:current_database).name
            end
          end
        end
      end
    end
  end
end
