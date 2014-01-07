module Mongoid
  module Shell
    module Properties
      module Password
        attr_accessor :password

        # current password
        def password
          @password || begin
            if Mongoid::Shell.mongoid2?
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless session && session.connection
              return nil unless session.connection.auths.any?
              session.connection.auths.first[:password]
            elsif Mongoid::Shell.mongoid3?
              return nil unless session.context.cluster.auth && session.context.cluster.auth.first
              session.context.cluster.auth.first[1][1]
            else
              node = session.cluster.nodes.first
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless node
              return nil unless node.credentials.has_key? db || node.credentials[db].empty?
              node.credentials[db][1]
            end
          end
        end
      end
    end
  end
end
