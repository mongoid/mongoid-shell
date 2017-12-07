module Mongoid
  module Shell
    module Properties
      module SSL
        attr_accessor :ssl

        def ssl
          return @ssl unless @ssl.nil?
          session.options['ssl']
        end
      end
    end
  end
end
