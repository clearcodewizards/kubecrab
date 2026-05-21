class Template < ApplicationRecord
  default_scope { order(:created_at) }

  belongs_to :engine

  has_many :template_options, dependent: :destroy
  has_many :crabs, dependent: :destroy
  has_many :user_templates, dependent: :destroy
  has_many :users, through: :user_templates

  enum :status, { active: 0, disabled: 1 }

  has_one_attached :avatar

  validates :name, presence: true, uniqueness: true

  scope :with_stripe, -> { where.not(stripe_payment_link: nil).where.not(stripe_payment_link: "") }

  def stripe?
    stripe_payment_link.present?
  end

  def payment_link(user)
    "#{stripe_payment_link}?client_reference_id=#{user.id}"
  end
end
