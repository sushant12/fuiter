Rails.configuration.stripe = {
  :publishable_key => Fuitter.credentials[:stripe_publishable_key],
  :secret_key      => Fuitter.credentials[:stripe_api_key],
  :signing_key => Fuitter.credentials[:stripe_signing_secret].
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.signing_secret = Rails.configuration.stripe[:signing_key]

StripeEvent.configure do |events|
  events.subscribe 'invoice.', Stripe::InvoiceEventHandler.new
end
