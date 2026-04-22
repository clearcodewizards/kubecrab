require "test_helper"

class TemplateOptionTest < ActiveSupport::TestCase
  test "normalizes empty provisioner to nil" do
    opt = TemplateOption.new(name: "key", template: templates(:default), provisioner: "")
    opt.validate
    assert_nil opt.provisioner
  end

  test "keeps non-empty provisioner as-is" do
    opt = TemplateOption.new(name: "key", template: templates(:default), provisioner: "OpenRouterApiKeyProvisioner")
    opt.validate
    assert_equal "OpenRouterApiKeyProvisioner", opt.provisioner
  end

  test "invalid without name" do
    opt = TemplateOption.new(template: templates(:default))
    assert_not opt.valid?
    assert_includes opt.errors[:name], "can't be blank"
  end

  test "invalid with duplicate name in same template" do
    opt = TemplateOption.new(name: template_options(:plain).name, template: templates(:default))
    assert_not opt.valid?
    assert_includes opt.errors[:name], "has already been taken"
  end

  test "valid with same name in different template" do
    other_template = Template.create!(
      name: "Other Template",
      template: "",
      engine: engines(:default)
    )
    opt = TemplateOption.new(name: template_options(:plain).name, template: other_template)
    assert opt.valid?
  end
end
