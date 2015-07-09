module Mongoid
  module Shell
    module Properties
      module Primary
        attr_accessor :primary

        # primary database host
        def primary
          @primary || begin
            fail Mongoid::Shell::Errors::SessionNotConnectedError unless session.cluster.nodes.any?
            node = session.cluster.nodes.find(&:primary?)
            fail Mongoid::Shell::Errors::MissingPrimaryNodeError unless node
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
