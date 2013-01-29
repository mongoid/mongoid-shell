module Mongoid
  module Shell
    module Properties
      module Password

        attr_accessor :password

        # current password
        def password
          @password || begin
            return nil unless session.context.cluster.auth && session.context.cluster.auth.first
            session.context.cluster.auth.first[1][1]
          end
        end

      end
    end
  end
end
