module Mongoid
  module Shell
    module Commands
      class Base
        attr_accessor :session

        class << self
          def command_for(session)
            new(session: session)
          end
        end

        def initialize(options = nil)
          options ||= {}
          options[:session] ||= default_client_or_session
          options.each do |sym, val|
            send "#{sym}=", val
          end
          raise Mongoid::Shell::Errors::MissingSessionError unless @session
        end

        def cmd
          self.class.name.downcase.split(':').last
        end

        def vargs(args = {})
          args.map do |key, property|
            value = send(property)
            next unless value
            case value
            when TrueClass then key
            when Array then value.map { |v| "#{key} #{v}" }.join(' ')
            else
              value = value.to_s
              # TODO: quote other special characters?
              value = '"' + value + '"' if value.include? ' '
              key[0] == '-' ? "#{key} #{value}" : value
            end
          end
        end

        def to_s
          [cmd, vargs].flatten.compact.join(' ')
        end

        private

        if ::Mongoid::Compatibility::Version.mongoid3? || ::Mongoid::Compatibility::Version.mongoid4?
          def default_client_or_session
            Mongoid.default_session
          end
        else
          def default_client_or_session
            Mongoid.default_client
          end
        end
      end
    end
  end
end
