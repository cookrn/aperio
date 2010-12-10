require 'test_helper'

class DefaultRoutingTest < ActionController::TestCase

  # This tests the route that the user is sent to authorize a client's access to protected resources
  test 'map oauth index' do
     assert_routing( { :path => 'oauth' , :method => :get } , { :controller => 'aperio/oauth' , :action => 'index' } )
  end

  # This tests the route that user credentials will be HTTP POSTed to to authenticate on the resource server
  test 'map oauth authenticate' do
    assert_routing( { :path => 'oauth/authenticate' , :method => :post } , { :controller => 'aperio/oauth' , :action => 'authenticate' } )
  end

end

