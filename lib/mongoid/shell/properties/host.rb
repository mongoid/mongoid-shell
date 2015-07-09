module Mongoid
  module Shell
    module Properties
      module Host
        attr_accessor :host

        # database host
        def host
          @host || begin
            node = session.cluster.nodes.first
            fail Mongoid::Shell::Errors::SessionNotConnectedError unless node
            if Mongoid::Shell.mongoid3?
              node.address == 'localhost:27017' ? nil : node.address
            else
              node.address.original == 'localhost:27017' ? nil : node.address.original
            end
          end
        end
      end
    end
  end
end
