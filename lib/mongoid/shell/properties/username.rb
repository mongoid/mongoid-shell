module Mongoid
  module Shell
    module Properties
      module Username

        # current username
        def username
          return nil unless session.context.cluster.auth && session.context.cluster.auth.first
          session.context.cluster.auth.first[1][0]
        end

      end
    end
  end
end
