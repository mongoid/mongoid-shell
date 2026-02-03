# frozen_string_literal: true

module Mongoid
  module Shell
    module Properties
      module Password
        attr_accessor :password

        # current password
        if ::Mongoid::Compatibility::Version.mongoid3?
          def password
            @password || begin
              return nil unless session.context.cluster.auth&.first

              session.context.cluster.auth.first[1][1]
            end
          end
        elsif ::Mongoid::Compatibility::Version.mongoid4?
          def password
            @password || begin
              node = session.cluster.nodes.first
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless node
              return nil if !node.credentials.key?(db) || node.credentials[db].empty?

              node.credentials[db][1]
            end
          end
        else
          def password
            @password || begin
              server = session.cluster.servers.first
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless server

              server.context.with_connection do |connection|
                connection.options[:password]
              end
            end
          end
        end
      end
    end
  end
end
