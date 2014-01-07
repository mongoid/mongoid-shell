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
          options[:session] ||= begin
            if Mongoid::Shell.mongoid2?
              Mongoid.master
            else
              Mongoid.default_session
            end
          end
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
            if value.is_a?(Boolean) || value.is_a?(TrueClass)
              key
            else
              value = value.to_s
              # TODO: quote other special characters?
              value = '"' + value + '"' if value.include? ' '
              key[0] == '-' ? "#{key} #{value}" : value
            end
          end
        end

        def to_s
          [cmd, vargs].flatten.compact.join(" ")
        end
      end
    end
  end
end
