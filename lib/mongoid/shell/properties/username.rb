# frozen_string_literal: true

module Mongoid
  module Shell
    module Properties
      module Username
        attr_accessor :username

        # current username
        if ::Mongoid::Compatibility::Version.mongoid3?
          def username
            @username || begin
              return nil unless session.context.cluster.auth&.first

              session.context.cluster.auth.first[1][0]
            end
          end
        elsif ::Mongoid::Compatibility::Version.mongoid4?
          def username
            @username || begin
              node = session.cluster.nodes.first
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless node
              return nil if !node.credentials.key?(db) || node.credentials[db].empty?

              node.credentials[db][0]
            end
          end
        else
          def username
            @username || session.options[:user]
          end
        end
      end
    end
  end
end
