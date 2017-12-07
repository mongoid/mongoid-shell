module Mongoid
  module Shell
    module Properties
      module AuthenticationDatabase
        attr_accessor :authenticationDatabase

        def authenticationDatabase
          @authenticationDatabase || session.options['auth_source']
        end
      end
    end
  end
end
