module Mongoid
  module Shell
    module Properties
      module Host

        # database host
        def host
          session.cluster.nodes.first.address
        end

      end
    end
  end
end