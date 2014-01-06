module Mongoid
  module Shell
    module Properties
      module Password

        attr_accessor :password

        # current password
        def password
          @password || begin
            node = session.cluster.nodes.first
            raise Mongoid::Shell::Errors::SessionNotConnectedError unless node
            return nil unless node.credentials && node.credentials.empty?
            node.credentials[1]
          end
        end

      end
    end
  end
end
