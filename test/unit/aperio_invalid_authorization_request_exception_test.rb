require 'test_helper'

class Aperio::Exceptions::InvalidAuthorizationRequestTest < Test::Unit::TestCase

  def setup
    @error = Aperio::Exceptions::InvalidAuthorizationRequestException.new('a_random_error')
  end

  def test_invalid_error_type_override
    assert_equal 'invalid-request' , @error.error_type
  end

  def test_error_query_string
    assert_equal 'error=invalid-request' , @error.error_query_string
  end

end # class Aperio::Exceptions::InvalidAuthorizationRequestTest
