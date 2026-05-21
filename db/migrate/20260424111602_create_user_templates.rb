class CreateUserTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :user_templates do |t|
      t.references :user, null: false, foreign_key: true
      t.references :template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
