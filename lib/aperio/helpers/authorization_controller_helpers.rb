module Aperio

  module Helpers

    module AuthorizationControllerHelpers

      # Params keys to always ignore for authorization requests
      IGNORED_AUTHORIZATION_REQUEST_KEYS = [ "controller" , "action" ]

      # Load our client and throw an exception and redirect if the client does not exist
      #
      # @return [NilClass]
      def load_client
        #unless @client = Aperio::Client.find_by_id params[:client_id]
      end

      # Load our authentication resource
      #
      # @return [NilClass]
      def load_authentication_resource; end

      # Persist the passed in client state parameter to the session
      #
      # @return [NilClass]
      def persist_client_state

        # Setup a session hash that can be utilized
        session[:aperio] = {}
        session[:aperio][:authorization_request] = {}

        # Persist each parameter to the session
        params.each do |k,v|
          session[:aperio][:authorization_request][k] = v unless IGNORED_AUTHORIZATION_REQUEST_KEYS.include?(k)
        end

      end

      # Run all the checks on the authorization request before authenticating the authorization resource
      def verify_authorization_request
        verify_required_oauth_parameters
        verify_response_type
        load_client
        verify_client
      end

      # Check whether our client exists and is authorized
      #
      # @return [NilClass]
      def verify_client; end

      # Check whether the server supports the requested response type
      #
      # @return [NilClass]
      def verify_response_type
        begin
          response_type = session[:aperio][:authorization_request]["response_type"]
          unless Aperio.supported_response_types.include? response_type
            raise Aperio::Exceptions::InvalidAuthorizationRequestException.new( :unsupported_response_type )
          end
        rescue Aperio::Exceptions::InvalidAuthorizationRequestException => e
          # @todo redirect or respond
        end
      end

      # Ensure that we have the necessary oauth parameters to authenticate the user
      # Set a flash message if there is no redirect_uri provided
      # Redirect to redirect_uri if other parameters are missing
      #
      # @return [NilClass]
      def verify_required_oauth_parameters

        # The necessary parameters as defined in the OAuth2 Draft Specification
        #
        # @see http://tools.ietf.org/html/draft-ietf-oauth-v2-11
        required_oauth_parameters = [ :redirect_uri , :response_type , :client_id ]

        # Set a flash message if we have no redirect_uri
        if params[:redirect_uri].nil?
          flash[:error] = "Required client parameters are missing."
        else

          # Prepare to rescue from an exception
          begin

            # Loop through our required keys to check for each one
            required_oauth_parameters.each do |key|

              # Check if our parameters include our key
              unless params.keys.include? key

                # Raise an exception if we are missing a required parameter
                raise Aperio::Exceptions::InvalidAuthorizationRequestException.new( :invalid_request )

                # End the loop if we are missing at least one required parameter
                break

              end

            end

          # Use the exception to generate the error query string
          rescue Aperio::Exceptions::InvalidAuthorizationRequestException => e

            go = Aperio::Helpers::RedirectUri.new do |uri|
              uri.base = session[:aperio][:authorization_request]["redirect_uri"]
              uri.append e.error_query_string

              # Only append key/value pairs to the redirect response that aren't in our required request params
              session[:aperio][:authorization_request].select { |key,val| !( required_oauth_parameters.include? key.to_sym ) }.each do |key,val|
                uri.append "#{key}=#{val}"
              end
            end

            redirect_to go.uri

          end

        end

      end # method verify_required_oauth_parameters

    end # module AuthorizationControllerHelpers

  end # module Helpers

end # module Aperio

