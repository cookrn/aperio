module Aperio

  module Exceptions

    # Requires
    require 'oauth/errors/error'

    class InvalidAuthorizationRequestException < OAuth::Error; end

  end

end

