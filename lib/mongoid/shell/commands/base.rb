module Mongoid
  module Shell
    module Commands
      class Base

        attr_reader :session

        def command_for(session)
          self.new({ session: session })
        end

        def initialize(options)
          @session = options[:sessions] if options
          raise Mongoid::Shell::Errors::MissingSessionError unless @session
        end

      end
    end
  end
end