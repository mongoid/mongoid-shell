module Mongoid
  module Shell
    module Properties
      module Host
        attr_accessor :host

        # database host
        def host
          @host || begin
            if Mongoid::Shell.mongoid2?
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless session && session.connection
              host_and_port = "#{session.connection.host}:#{session.connection.port}"
              host_and_port == "localhost:27017" ? nil : host_and_port
            else
              node = session.cluster.nodes.first
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless node
              if Mongoid::Shell.mongoid3?
                node.address == "localhost:27017" ? nil : node.address
              else
                node.address.original == "localhost:27017" ? nil : node.address.original
              end
            end
          end
        end
      end
    end
  end
end
