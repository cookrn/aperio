require 'test_helper'

class Aperio::OauthControllerTest < ActionController::TestCase

  # Test that our index route is accessible
  test 'index should be accessible' do
    get :index
    assert_response :success
  end

  # Test that request with no parameters sets a flash message
  test 'index shows a flash message' do
    get :index
    assert_equal "Required client parameters are missing." , flash[:error]
  end

  # Test that a request with a request with partial parameters including a redirect_uri redirects
  test 'index redirects to redirect_uri if other required parameters are missing' do
    parameters = { :redirect_uri => 'http://example.com/callback' }
    get :index , parameters
    assert_redirected_to parameters[:redirect_uri]
  end

  # Test that we are persisting the state parameter to the session if it exists
  test 'persist state parameter to session if it is passed' do
    parameters = {
      :client_id => 'a_client_id',
      :redirect_uri => 'http://example.com/callback',
      :response_type => 'a_response_type',
      :state => 'a_client_state_identifier'
    }
    get :index , parameters
    assert_equal parameters[:state] , session[:aperio]['oauth_request_state']
  end

  # Test that posting nothing will return the appropriate error response
  test 'POSTing nothing gives us an error response' do
    post :authenticate, {}
    assert_redirected_to aperio_oauth_index_path
    assert_equal "You must provide credentials." , flash[:error]
  end

end

