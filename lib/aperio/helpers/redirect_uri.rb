module Aperio

  module Helpers

    class RedirectUri

      attr_accessor :base
      attr_reader :appensions , :uri

      # Standard class init
      #
      # @return [String] the full redirect uri
      def initialize
        @appensions = []
        yield self
        construct
      end

      # Pass in a key and value to append to append this in the redirect query string
      #
      # @param [String] A query string key/value pair
      # @return [NilClass]
      def append( appension )
        appensions << appension
      end

      private

      # Construct a full/proper redirect uri including any additions
      #
      # @return [String] The full redirect_uri with all the appropriate data
      def construct
        @uri = "#{proper_base}#{appensions.join('&')}"
      end

      # Check whether our base already has a query string and return appropriately
      #
      # @return [String] Our base redirect URI
      def proper_base
        # The regex used matches the following sample urls
        # http://thing.thing.example.com/callback.thing/other_thing?sample_param=x&other_param=y
        # app://thing.thing.example.com/callback.thing/other_thing?sample_param=x
        # app://app.x/callback.thing/other_thing?sample_param=x&other_param=y
        # app://app_handler/callback.thing/other_thing?sample_param=x&other_param=y
        ( base =~ /\w+:\/\/.+?(\.\w+)?\/.*?\?.+/ ) ? "#{base}&" : "#{base}?"
      end

    end

  end

end

