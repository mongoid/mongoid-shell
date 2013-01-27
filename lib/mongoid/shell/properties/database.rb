module Mongoid
  module Shell
    module Properties
      module Database

        # current database name
        def database_name
          session.send(:current_database).name
        end

      end
    end
  end
end