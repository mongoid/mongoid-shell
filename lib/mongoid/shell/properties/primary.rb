module Mongoid
  module Shell
    module Properties
      module Primary

        attr_accessor :primary

        # primary database host
        def primary
          @primary || begin
            raise Mongoid::Shell::Errors::SessionNotConnectedError unless session.cluster.nodes.any?
            node = session.cluster.nodes.find(&:primary?)
            raise Mongoid::Shell::Errors::MissingPrimaryNodeError unless node
            node.address.original == "localhost:27017" ? nil : node.address.original
          end
        end

      end
    end
  end
end
