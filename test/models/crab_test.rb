require "test_helper"

class CrabTest < ActiveSupport::TestCase
  test "normalizes name to downcase" do
    crab = Crab.new(name: "DownCase")
    assert_equal "downcase", crab.name
  end
end
