module Aperio

  class OauthAuthorizationController < ApplicationController

    # Includes
    include Aperio::Helpers::AuthorizationControllerHelpers

    # Filters
    before_filter :persist_client_state , :only => [ :index ]
    before_filter :load_authentication_model, :only => [ :authenticate ]
    before_filter :verify_authorization_request , :only => [ :index ]

    # HTTP POST Only
    # Authenticates a user
    def authenticate
      flash[:error] = "You must provide credentials."
      redirect_to :action => :index
    end

    # HTTP GET Only
    # Displays the user authentication form
    def index; end

  end # class OauthAuthorizationController

end # module Aperio

