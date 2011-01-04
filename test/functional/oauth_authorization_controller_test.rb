require 'test_helper'

class Aperio::OauthAuthorizationControllerTest < ActionController::TestCase

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

  # Test that all parameters are persisted to the session
  test 'all passed parameters are persisted to the session' do
    parameters = {
      :redirect_uri => 'http://example.com/callback',
      :response_type => 'a_response_type',
      :client_id => 'a_client_id',
      :state => 'a_client_state'
    }
    get :index , parameters
    assert_equal parameters[:redirect_uri] , session[:aperio][:authorization_request]["redirect_uri"]
    assert_equal parameters[:response_type] , session[:aperio][:authorization_request]["response_type"]
    assert_equal parameters[:client_id] , session[:aperio][:authorization_request]["client_id"]
    assert_equal parameters[:state] , session[:aperio][:authorization_request]["state"]
  end

  # Test that a request with partial parameters including a redirect_uri redirects
  test 'index redirects to redirect_uri if other required parameters are missing' do
    parameters = {
      :redirect_uri => 'http://example.com/callback',
      :state => 'a_client_state'
    }
    get :index , parameters
    assert_redirected_to "#{parameters[:redirect_uri]}?error=invalid-request&state=a_client_state"
  end

  # Test that an invalid request that already includes a query string still redirects properly
  test 'index redirects properly to redirect_uri that already includes query string' do
    parameters = {
      :redirect_uri => 'http://example.com/callback?query_string_key=query_string_value',
      :state => 'a_client_state'
    }
    get :index , parameters
    assert_redirected_to "#{parameters[:redirect_uri]}&error=invalid-request&state=a_client_state"
  end

  # Test that posting nothing will return the appropriate error response
  test 'POSTing nothing gives us an error response' do
    post :authenticate, {}
    assert_redirected_to aperio_oauth_index_path
    assert_equal "You must provide credentials." , flash[:error]
  end

end

