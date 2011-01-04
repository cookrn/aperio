# Requires
require 'oauth/errors/error'

module Aperio

  module Exceptions

    class BaseException < OAuth::Error

      # The possible error types that might be returned to a client
      @@error_types = [ :invalid_request , :invalid_client_id , :unauthorized_client , :redirect_uri_mismatch , :access_denied , :unsupported_response_type , :invalid_scope ]

    end

  end

end

