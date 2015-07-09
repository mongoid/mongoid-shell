module Mongoid
  module Shell
    module Errors
      class SessionNotConnectedError < Mongoid::Shell::Errors::Base
        def initialize
          super(compose_message('session_not_connected'))
        end
      end
    end
  end
end
