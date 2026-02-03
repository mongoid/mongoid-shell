# frozen_string_literal: true

module MongoidSessionHelper
  if ::Mongoid::Compatibility::Version.mongoid3? || ::Mongoid::Compatibility::Version.mongoid4?
    def default_client_or_session
      Mongoid.default_session
    end
  else
    def default_client_or_session
      Mongoid.default_client
    end
  end
end
