# Requires
require 'oauth/errors/error'

module Aperio

  module Exceptions

    class InvalidAuthorizationRequestException < OAuth::Error

      attr_reader :error_type

      # Acceptable error types
      POSSIBLE_TYPES = [ :invalid_request , :invalid_client_id , :unauthorized_client , :redirect_uri_mismatch , :access_denied , :unsupported_response_type , :invalid_scope ]

      # Standard class init
      #
      # @param [Symbol] The type of error
      def initialize( type , *args )
        @error_type = "invalid-request"
        verify_type type
      end

      # Verifies the error type
      #
      # @param [Symbol] The passed in error type
      # @return [NilClass]
      def verify_type( type )
        @error_type = type.to_s.dup.dasherize if POSSIBLE_TYPES.include?(type)
      end

      # Returns the error query string
      #
      # @return [String] The query string params related to the error
      def error_query_string
        "error=#{@error_type}"
      end

    end

  end

end

