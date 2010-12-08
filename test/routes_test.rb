require 'test_helper'

class DefaultRoutingTest < ActionController::TestCase

  test 'map oauth authorize' do
    assert_routing( { :path => 'oauth/authorize' , :method => :post } , { :controller => 'aperio/oauth' , :action => 'authorize' } )
  end

  test 'map oauth request_token' do
    assert_routing( { :path => 'oauth/request_token' , :method => :get } , { :controller => 'aperio/oauth' , :action => 'request_token' } )
  end

  test 'map oauth access_token' do
    assert_routing( { :path => 'oauth/access_token' , :method => :get } , { :controller => 'aperio/oauth' , :action => 'access_token' } )
  end

  test 'map oauth token' do
    assert_routing( { :path => 'oauth/token' , :method => :get } , { :controller => 'aperio/oauth' , :action => 'token' } )
  end

end

