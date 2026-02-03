# frozen_string_literal: true

module Mongoid
  module Shell
    module Properties
      module Primary
        attr_accessor :primary

        # primary database host
        if ::Mongoid::Compatibility::Version.mongoid3?
          def primary
            @primary || begin
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless session.cluster.nodes.any?

              node = session.cluster.nodes.find(&:primary?)
              raise Mongoid::Shell::Errors::MissingPrimaryNodeError unless node

              node.address == 'localhost:27017' ? nil : node.address
            end
          end
        elsif ::Mongoid::Compatibility::Version.mongoid4?
          def primary
            @primary || begin
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless session.cluster.nodes.any?

              node = session.cluster.nodes.find(&:primary?)
              raise Mongoid::Shell::Errors::MissingPrimaryNodeError unless node

              node.address.original == 'localhost:27017' ? nil : node.address.original
            end
          end
        else
          def primary
            @primary || begin
              raise Mongoid::Shell::Errors::SessionNotConnectedError unless session.cluster.servers.any?

              node = session.cluster.servers.find { |server| server.primary? || server.standalone? }
              raise Mongoid::Shell::Errors::MissingPrimaryNodeError unless node

              node.address.to_s == 'localhost:27017' ? nil : node.address.to_s
            end
          end
        end
      end
    end
  end
end
