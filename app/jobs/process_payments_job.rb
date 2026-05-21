class ProcessPaymentsJob < ApplicationJob
  queue_as :default

  def perform
    StripePaymentProvider.new(logger).process_payments
  end
end
