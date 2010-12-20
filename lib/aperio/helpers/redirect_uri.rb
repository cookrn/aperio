module Aperio

  module Helpers

    class RedirectUri

      attr_accessor :base

      def initialize(&blk)
        yield self
        construct
      end

      def append

      end

      def construct

      end

      # Construct a full/proper redirect uri including any additions
      #
      # @param [String] The error type to respond with
      # @param [String] An optional error description
      # @return [String] The full redirect_uri with all appropriate data
      def proper_error_redirect_uri( error_type , error_description = nil )
        full_redirect_uri = params[:redirect_uri]

        # Check whether our redirect uri already has a query string and start our query string appropriately
        #
        # The regex used matches the following sample urls
        # http://thing.thing.example.com/callback.thing/other_thing?sample_param=x&other_param=y
        # app://thing.thing.example.com/callback.thing/other_thing?sample_param=x
        # app://app.x/callback.thing/other_thing?sample_param=x&other_param=y
        # app://app_handler/callback.thing/other_thing?sample_param=x&other_param=y
        full_redirect_uri << ( full_redirect_uri =~ /\w+:\/\/.+?(\.\w+)?\/.*?\?.+/ ) ? '&' : '?'

        # Add on our data
        full_redirect_uri << "error=#{error_type}"
        full_redirect_uri << "&error_description=" unless error_description.nil?
        full_redirect_uri << "&state=#{session[:aperio]['oauth_request_state']}" unless session[:aperio]['oauth_request_state'].nil?

        full_redirect_uri
      end

    end

  end

end
