module Aperio
  class OauthController < ActionController::Base

    # HTTP POST Only
    # Authenticates a user
    def authenticate
      flash[:error] = "You must provide credentials."
      redirect_to :action => :index
    end

    # HTTP GET Only
    # Displays the user authentication form
    def index
      persist_client_state
      verify_required_oauth_parameters
    end

    private

    # Persist the passed in client state parameter to the session
    #
    # @return [NilClass]
    def persist_client_state

      # Setup a session hash that can be utilized
      session[:aperio] = {}
      session[:aperio][:authorization_request] = {}

      # Persist each parameter to the session
      params.each do |k,v|
        session[:aperio][:authorization_request][k] = v
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
              raise Aperio::Exceptions::InvalidAuthorizationRequestException.new(key)

              # End the loop if we are missing at least one required parameter
              break

            end

          end

        # Use the exception to generate the error query string
        rescue Aperio::Exceptions::InvalidAuthorizationRequestException => e

          redirect_to Aperio::Helpers::RedirectUri.new do |uri|
            uri.base = session[:aperio][:authorization_request]["redirect_uri"]
            uri.append e.error_query_string
            uri.append session[:aperio][:authorization_request].select { |key,val| !( required_oauth_parameters.include key.to_sym ) }
          end

        end

      end

    end

  end

end

