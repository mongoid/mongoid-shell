module Mongoid
  module Shell
    module Commands
      class Base
        attr_accessor :session

        class << self
          attr_accessor :args
          @args = {}

          def inherit_args(args)
            @args ||= {}
            @args.merge(args || {})
          end

          def inherited(sublass)
            sublass.inherit_args(@args)
          end

          def command_for(session)
            new(session: session)
          end

          def arg(name, options = {})
            attr_accessor name unless instance_methods.include?(name)
            args[name] = { property: name }.merge(options)
          end

          def option(name, options = {})
            attr_accessor name unless instance_methods.include?(name)
            args[name] = { key: "--#{name}", property: name }.merge(options)
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

        def vargs
          self.class.args.values.map do |arg|
            key = arg[:key]
            value = send(arg[:property])
            next unless value
            case value
            when Boolean, TrueClass then key
            when Array then value.map { |v| "#{key} #{v}" }.join(' ')
            else
              value = value.to_s
              # TODO: quote other special characters?
              value = '"' + value + '"' if value.include? ' '
              key ? "#{key} #{value}" : value
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
