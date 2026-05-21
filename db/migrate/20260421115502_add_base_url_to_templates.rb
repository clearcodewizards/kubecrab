# frozen_string_literal: true

class AddBaseUrlToTemplates < ActiveRecord::Migration[8.0]
  def change
    add_column :templates, :base_url, :string, default: "crabs.example.com", null: false
  end
end
