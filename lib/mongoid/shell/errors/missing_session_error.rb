module Mongoid
  module Shell
    module Errors
      class MissingSessionError < Mongoid::Shell::Errors::Base
        def initialize
          super(compose_message('missing_session'))
        end
      end
    end
  end
end
