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

      # Check if the state param exists
      if !params[:state].nil? && params[:state] != ''

        # Setup a session hash that can be utilized
        session[:aperio] ||= {}
        session[:aperio]['oauth_request_state'] = params[:state]

      end

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
            redirect_to proper_error_redirect_uri('invalid-request')
            break
          end

        end

      end

    end

  end

end

