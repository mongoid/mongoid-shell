# frozen_string_literal: true

module Mongoid
  module Shell
    module Properties
      module Host
        attr_accessor :host

        # database host
        if ::Mongoid::Compatibility::Version.mongoid3?
          def host
            @host || begin
              node = session.cluster.nodes.first
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless node

              node.address == 'localhost:27017' ? nil : node.address
            end
          end
        elsif ::Mongoid::Compatibility::Version.mongoid4?
          def host
            @host || begin
              node = session.cluster.nodes.first
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless node

              node.address.original == 'localhost:27017' ? nil : node.address.original
            end
          end
        else
          def host
            @host || begin
              node = session.cluster.servers.first
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless node

              node.address.to_s == 'localhost:27017' ? nil : node.address.to_s
            end
          end
        end
      end
    end
  end
end
