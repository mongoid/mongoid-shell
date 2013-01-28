module Mongoid
  module Shell
    module Commands
      class Base

        attr_accessor :session

        class << self

          def command_for(session)
            self.new({ session: session })
          end

        end

        def initialize(options = nil)
          options ||= {}
          options[:session] ||= Mongoid.default_session
          options.each do |sym, val|
            self.send "#{sym}=", val
          end
          raise Mongoid::Shell::Errors::MissingSessionError unless @session
        end

        def cmd
          self.class.name.downcase.split(':').last
        end

        def vargs(args = {})
          args.map do |key, property|
            value = self.send(property)
            next unless value
            # TODO: quote other special characters?
            value = '"' + value + '"' if value.include? ' '
            key[0] == '-' ? "#{key} #{value}" : value
          end
        end

        def to_s
          [ self.cmd, vargs ].flatten.compact.join(" ")
        end

      end
    end
  end
end
