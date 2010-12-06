require 'test_helper'

class AperioTest < ActiveSupport::TestCase

  test "truth" do
    assert_kind_of Module, Aperio
  end

  test 'setup block yields self' do
    Aperio.setup do |config|
      assert_equal Aperio, config
    end
  end

end

