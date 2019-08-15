Stripe.api_key = Fuitter.credentials[:stripe_api_key]

StripeEvent.signing_secret = Fuitter.credentials[:stripe_signing_secret]

StripeEvent.configure do |events|
  events.subscribe 'invoice.', Stripe::InvoiceEventHandler.new
end
