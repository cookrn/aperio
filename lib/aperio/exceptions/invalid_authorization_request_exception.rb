module Aperio

  module Exceptions

    class InvalidAuthorizationRequestException < OAuth::Error

      attr_reader :error_type

      # Standard class init
      #
      # @param [Symbol] The type of error
      def initialize( type )
        verify_type type
      end

      # Verifies the error type
      #
      # @param [Symbol] The passed in error type
      # @return [NilClass]
      def verify_type( type )
        @error_type = ( @@error_types.include?(type) ) ? type.to_s.dup.dasherize : "invalid-request"
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

