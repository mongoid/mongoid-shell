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
            return nil unless node.credentials.has_key? db || node.credentials[db].empty?
            node.credentials[db][0]
          end
        end

        private
          def db
            @db || session.send(:current_database).name
          end

      end
    end
  end
end
