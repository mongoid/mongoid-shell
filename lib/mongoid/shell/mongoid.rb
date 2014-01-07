module Mongoid
  module Shell
    def self.mongoid3?
      ::Mongoid.const_defined? :Observer # deprecated in Mongoid 4.x
    end
  end
end
