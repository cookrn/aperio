require 'test_helper'

class AperioTest < ActiveSupport::TestCase

  # This tests that we have our engine library defined correctly
  test "truth" do
    assert_kind_of Module, Aperio
  end

  # This tests that we have properly implemented our libary setup method
  test 'setup block yields self' do
    Aperio.setup do |config|
      assert_equal Aperio, config
    end
  end

  # Test that we can set a route namespace
  test 'setting a route namespace in the setup block' do
    test_namespace = '/test'
    Aperio.setup do |config|
      config.route_namespace = test_namespace
    end
    assert_equal test_namespace , Aperio.route_namespace
  end

  # Test that we are able to set a custom authentication model
  test 'setting a custom authentication model in the setup block' do
    test_authentication_model = 'Test'
    Aperio.setup do |config|
      config.authentication_model = test_authentication_model
    end
    assert_equal test_authentication_model , Aperio.authentication_model
  end

  # Test that we are able to set a custom authentication identifier
  test 'setting a custom authentication identifier in the setup block' do
    test_authentication_identifier = 'username'
    Aperio.setup do |config|
      config.authentication_identifier = test_authentication_identifier
    end
    assert_equal test_authentication_identifier , Aperio.authentication_identifier
  end

  # Test that we are able to set a custom authentication secret
  test 'setting a custom authentication secret in the setup block' do
    test_authentication_secret = 'passkey'
    Aperio.setup do |config|
      config.authentication_secret = test_authentication_secret
    end
    assert_equal test_authentication_secret , Aperio.authentication_secret
  end

  # Test that we are able to set the allowed response types
  test 'setting a custom array of allowed response types in the setup block' do
    test_response_types = [ :code_and_token ]
    Aperio.setup do |config|
      config.supported_response_types = test_response_types
    end
    assert_equal test_response_types , Aperio.supported_response_types
  end

end

