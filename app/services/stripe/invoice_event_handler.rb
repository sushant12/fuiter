module Stripe
  class InvoiceEventHandler
    def call(event)
      begin
        method = "handle_" + event.type.tr('.', '_')
        self.send method, event
      rescue JSON::ParserError => e
        render json: {:status => 400, :error => "Invalid payload"}
        return
      rescue NoMethodError => e
      end
    end

    def handle_invoice_payment_failed(event)
      fb_page_template = FbPageTemplate.find_by(payment_gateway_subscription_id: event.data.object.lines.data.first.subscription)
      fb_page_template.fb_page.update({status: 'expired'})
      subs = ::Subscription.new
      subs.start_date = DateTime.strptime(event.data.object.lines.data.first.period.start.to_s,'%s')
      subs.end_date = DateTime.strptime(event.data.object.lines.data.first.period.end.to_s,'%s')
      subs.status = "failed"
      subs.payment_gateway = "stripe"
      subs.payment_gateway_subscription_id = event.data.object.lines.data.first.subscription
      subs.user_id = User.find_by(stripe_id: event.data.object.customer).id
      subs.fb_page_template_id = FbPageTemplate.find_by(payment_gateway_subscription_id: event.data.object.lines.data.first.subscription).id
      subs.meta_data = event
      subs.save!
    end

    def handle_invoice_payment_succeeded(event)
      subs = ::Subscription.new
      subs.start_date = DateTime.strptime(event.data.object.lines.data.first.period.start.to_s,'%s')
      subs.end_date = DateTime.strptime(event.data.object.lines.data.first.period.end.to_s,'%s')
      subs.status = "success"
      subs.payment_gateway = "stripe"
      subs.payment_gateway_subscription_id = event.data.object.lines.data.first.subscription
      subs.user_id = User.find_by(stripe_id: event.data.object.customer).id
      subs.fb_page_template_id = FbPageTemplate.find_by(payment_gateway_subscription_id: event.data.object.lines.data.first.subscription).id
      subs.meta_data = event
      subs.save!
    end
  end
end