module Mongoid
  module Shell
    module Errors
      class MissingPrimaryNodeError < Mongoid::Shell::Errors::Base
        def initialize
          super(compose_message("missing_primary_node"))
        end
      end
    end
  end
end
