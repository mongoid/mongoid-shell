# frozen_string_literal: true

module MongoidSessionHelper
  if ::Mongoid::Compatibility::Version.mongoid5_or_newer?
    def default_client_or_session
      Mongoid.default_client
    end
  else
    def default_client_or_session
      Mongoid.default_session
    end
  end
end
