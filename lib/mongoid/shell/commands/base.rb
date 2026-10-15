# frozen_string_literal: true

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
            attr_accessor name unless method_defined?(name)
            args[name] = { property: name }.merge(options)
          end

          def option(name, options = {})
            attr_accessor name unless method_defined?(name)
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

        def vargs(options = {})
          mask_sensitive = options[:mask_sensitive]
          mask_sensitive = '********' if mask_sensitive.is_a?(TrueClass)
          self.class.args.values.map do |arg|
            key = arg[:key]
            value = send(arg[:property])
            next unless value

            case value
            when Boolean, TrueClass then key
            when Array then value.map { |v| "#{key} #{v}" }.join(' ')
            else
              value = format_value(value, arg, mask_sensitive)
              key ? "#{key} #{value}" : value
            end
          end
        end

        def to_s(options = {})
          [cmd, vargs(options)].flatten.compact.join(' ')
        end

        private

        def format_value(value, arg, mask_sensitive)
          return mask_sensitive if mask_sensitive && arg[:sensitive]

          if arg[:json]
            value = ::JSON.generate(value) if value.is_a?(Hash)
            Shellwords.escape(value.to_s)
          else
            value = value.to_s
            value.include?(' ') ? "\"#{value}\"" : value
          end
        end

        if ::Mongoid::Compatibility::Version.mongoid5_or_newer?
          def default_client_or_session
            Mongoid.default_client
          end
        else
          def default_client_or_session
            Mongoid.default_session
          end
        end
      end
    end
  end
end
