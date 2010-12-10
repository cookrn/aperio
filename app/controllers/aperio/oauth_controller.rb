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

      # Setup a session hash that can be utilized
      session[:aperio] = {}

      verify_required_oauth_parameters
      persist_client_state if params[:state]
    end

    private

    # Ensure that we have the necessary oauth parameters to authenticate the user
    # Set a flash message if there is no redirect_uri provided
    # Redirect to redirect_uri if other parameters are missing
    #
    # @return [NilClass]
    def verify_required_oauth_parameters

      # The necessary parameters as defined in the OAuth2 Draft Specification
      #
      # @references [http://tools.ietf.org/html/draft-ietf-oauth-v2-11]
      required_oauth_parameters = [ :redirect_uri , :response_type , :client_id ]

      # Set a flash message if we have no redirect_uri
      if params[:redirect_uri].nil?
        flash[:error] = "Required client parameters are missing."
      else

        # Loop through our required keys to check for each one
        required_oauth_parameters.each do |key|

          # Redirect if we are missing a required parameter
          unless params.keys.include? key
            redirect_to params[:redirect_uri]
            break
          end

        end

      end

    end

    # Persist the passed in client state parameter to the session
    #
    # @return [NilClass]
    def persist_client_state
      session[:aperio]['oauth_request_state'] = params[:state]
    end

  end

end

