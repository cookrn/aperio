module Aperio

  module Exceptions

    # Autoloads
    autoload :InvalidAuthorizationRequestException , 'aperio/exceptions/invalid_authorization_request_exception'

  end

end

# Requires
require 'oauth/errors/error'

# Monkey-patch some things in to the base error class from the OAuth gem
class OAuth::Error

  # The possible error types that might be returned to a client
  @@error_types = [ :invalid_request , :invalid_client_id , :unauthorized_client , :redirect_uri_mismatch , :access_denied , :unsupported_response_type , :invalid_scope ]

end

