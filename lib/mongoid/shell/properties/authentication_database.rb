# frozen_string_literal: true

module Mongoid
  module Shell
    module Properties
      module AuthenticationDatabase
        attr_accessor :authenticationDatabase

        def authenticationDatabase
          @authenticationDatabase || begin
            auth_source = session.options['auth_source']
            auth_source unless auth_source == db
          end
        end
      end
    end
  end
end
