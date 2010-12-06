require 'test_helper'

class DefaultRoutingTest < ActionController::TestCase

  test 'map oauth index' do
    assert_recognizes({:controller => 'aperio/oauth_provider', :action => 'index'}, {:path => '/oauth', :method => :get})
    assert_named_route "/oauth", :aperio_oauth_index
  end

end

