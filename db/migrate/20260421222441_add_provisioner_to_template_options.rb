class AddProvisionerToTemplateOptions < ActiveRecord::Migration[8.0]
  def change
    add_column :template_options, :provisioner, :string
  end
end
