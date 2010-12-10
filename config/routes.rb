Rails.application.routes.draw do

  # This adds our engine's routes to the host rails application scoped to our engine module
  scope :module => :aperio do

    # Add our HTTP GET only index route that a client will direct a user to
    match "#{Aperio.route_namespace}", :to => 'oauth#index', :as => :aperio_oauth_index, :via => :get

    # Add our HTTP POST only authenticate route that the authentication form will post to
    match "#{Aperio.route_namespace}/authenticate", :to => 'oauth#authenticate', :as => :aperio_oauth_authenticate, :via => :post

  end

end

