require "test_helper"

class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper

  test "available_provisioners includes OpenRouterApiKeyProvisioner" do
    assert_includes available_provisioners, "UnixTimestampProvisioner"
  end

  test "available_provisioners returns a sorted list" do
    result = available_provisioners
    assert_equal result.sort, result
  end

  test "available_provisioners excludes .keep files" do
    result = available_provisioners
    assert_not_includes result, ".keep"
    result.each { |name| assert name.present? }
  end
end
