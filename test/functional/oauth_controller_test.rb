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
      :response_type => 'code',
      :state => 'a_client_state_identifier'
    }
    get :index , parameters
    assert_equal parameters[:state] , session[:aperio]['oauth_request_state']
  end

  # Test that our state parameter is included in a redirect if present
  test 'state parameter is included in redirect' do
    parameters = {
      :redirect_uri => 'http://example.com/callback',
      :state => 'a_client_state_identifier'
    }
    get :index , parameters
    assert_redirected_to "#{parameters[:redirect_uri]}?state=#{parameters[:state]}"
  end

  # Test that we get redirected with the appropriate error code if an invalid response_type is passed in
  test 'redirect if invalid response_type' do
    parameters = {
      :client_id => 'a_client_id',
      :redirect_uri => 'http://example.com/callback',
      :response_type => 'bad_response_type'
    }
    get :index , parameters
    assert_redirected_to "#{parameters[:redirect_uri]}&error=unsupported-response-type"
  end

  # Test that posting nothing will return the appropriate error response
  test 'POSTing nothing gives us an error response' do
    post :authenticate, {}
    assert_redirected_to aperio_oauth_index_path
    assert_equal "You must provide credentials." , flash[:error]
  end

end

