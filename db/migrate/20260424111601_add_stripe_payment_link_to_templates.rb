# frozen_string_literal: true

class AddStripePaymentLinkToTemplates < ActiveRecord::Migration[8.0]
  def change
    add_column :templates, :stripe_payment_link, :string
  end
end
