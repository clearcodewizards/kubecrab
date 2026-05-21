class Crab < ApplicationRecord
  after_commit :broadcast_update, if: :saved_change_to_status?

  belongs_to :template
  belongs_to :user

  encrypts :options
  serialize :options, coder: JSON

  enum :status, { creating: 0, running: 1, restarting: 2, upgrading: 3, error: 4, stopping: 5, stopped: 6, deleting: 7 }

  normalizes :name, with: ->(name) { name.downcase.strip.tr(" ", "-") }
  validates :name, presence: true

  private

  def broadcast_update
    broadcast_replace_to(:crabs, partial: "crabs/crab", locals: { crab: self })
  end
end
