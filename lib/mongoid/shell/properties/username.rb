module Mongoid
  module Shell
    module Properties
      module Username

        attr_accessor :username

        # current username
        def username
          @username || begin
            node = session.cluster.nodes.first
            raise Mongoid::Shell::Errors::SessionNotConnectedError unless node
            return nil unless node.credentials && node.credentials.empty?
            node.credentials[0]
          end
        end

      end
    end
  end
end
