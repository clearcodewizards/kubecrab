# frozen_string_literal: true

class AddLimitToTemplates < ActiveRecord::Migration[8.0]
  def change
    add_column :templates, :limit, :integer, default: 1, null: false
  end
end
