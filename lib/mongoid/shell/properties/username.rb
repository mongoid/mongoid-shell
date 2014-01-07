module Mongoid
  module Shell
    module Properties
      module Username
        attr_accessor :username

        # current username
        def username
          @username || begin
            if Mongoid::Shell.mongoid3?
              return nil unless session.context.cluster.auth && session.context.cluster.auth.first
              session.context.cluster.auth.first[1][0]
            else
              node = session.cluster.nodes.first
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless node
              return nil unless node.credentials.has_key? db || node.credentials[db].empty?
              node.credentials[db][0]
            end
          end
        end
      end
    end
  end
end
