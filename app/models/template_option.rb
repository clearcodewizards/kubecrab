class TemplateOption < ApplicationRecord
  belongs_to :template

  normalizes :provisioner, with: ->(v) { v.presence }

  validates :name, presence: true, uniqueness: { scope: :template_id }
end
