module Mongoid
  module Shell
    module Properties
      module Password
        attr_accessor :password

        # current password
        def password
          @password || begin
            if Mongoid::Shell.mongoid3?
              return nil unless session.context.cluster.auth && session.context.cluster.auth.first
              session.context.cluster.auth.first[1][1]
            else
              node = session.cluster.nodes.first
              fail Mongoid::Shell::Errors::SessionNotConnectedError unless node
              return nil if !node.credentials.key?(db) || node.credentials[db].empty?
              node.credentials[db][1]
            end
          end
        end
      end
    end
  end
end
