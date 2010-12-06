Rails.application.routes.draw do

  #scope our routes to the engine
  scope :module => "aperio" do
    match '/oauth', :to => 'oauth_provider#index', :as => :oauth_index
  end

end

