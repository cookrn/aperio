Rails.application.routes.draw do

  # This adds our engine's routes to the host rails application scoped to our engine module
  scope Aperio.route_namespace , :module => :aperio , :as => :aperio do

    # Add our HTTP GET only index route that a client will direct a user to
    match "/", :to => 'oauth#index', :as => :oauth_index, :via => :get

    # Add our HTTP POST only authenticate route that the authentication form will post to
    match "authenticate", :to => 'oauth#authenticate', :as => :oauth_authenticate, :via => :post

  end

end

