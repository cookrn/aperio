Rails.application.routes.draw do

  #scope our routes to the engine
  scope :module => "aperio" do
    match '/oauth/authorize', :to => 'oauth#authorize', :as => :oauth_authorize, :via => :post
    match '/oauth/request_token', :to => 'oauth#request_token', :as => :oauth_request_token
    match '/oauth/access_token', :to => 'oauth#access_token', :as => :oauth_access_token
    match '/oauth/token', :to => 'oauth#token', :as => :oauth_token
  end

end

