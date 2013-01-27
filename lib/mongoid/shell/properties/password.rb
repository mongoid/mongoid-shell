module Mongoid
  module Shell
    module Properties
      module Password

        # current password
        def password
          return nil unless session.context.cluster.auth && session.context.cluster.auth.first
          session.context.cluster.auth.first[1][1]
        end

      end
    end
  end
end