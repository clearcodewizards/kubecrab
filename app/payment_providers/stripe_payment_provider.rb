require "stripe"

class StripePaymentProvider
  def initialize(logger)
    @client = Stripe::StripeClient.new(Rails.application.credentials.dig(:stripe, :key))
    @logger = logger
  end

  def process_payments
    @client.v1.checkout.sessions.list(status: :complete).each do |checkout|
      next unless checkout["payment_status"] == "paid"

      payment_link = @client.v1.payment_links.retrieve(checkout["payment_link"])
      template = Template.find_by(stripe_payment_link: payment_link["url"])
      next @logger.error "Template not found for stripe checkout #{checkout['id']}" unless template

      user = User.find_by(id: checkout["client_reference_id"])
      next @logger.error "User not found for stripe checkout #{checkout['id']}" unless user

      user.templates << template unless user.templates.exists?(template.id)
    end
  end
end
