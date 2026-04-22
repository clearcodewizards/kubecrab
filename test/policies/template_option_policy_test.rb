require "test_helper"

class TemplateOptionPolicyTest < ActiveSupport::TestCase
  test "scope returns all template options for admin" do
    admin = users(:admin)
    scope = TemplateOptionPolicy::Scope.new(admin, TemplateOption).resolve
    assert_includes scope, template_options(:plain)
    assert_includes scope, template_options(:with_provisioner)
  end

  test "scope returns no template options for non-admin" do
    member = users(:member)
    scope = TemplateOptionPolicy::Scope.new(member, TemplateOption).resolve
    assert_equal 0, scope.count
  end

  test "permitted_attributes includes name and provisioner" do
    policy = TemplateOptionPolicy.new(users(:admin), template_options(:plain))
    assert_equal %i[name provisioner], policy.permitted_attributes
  end
end
