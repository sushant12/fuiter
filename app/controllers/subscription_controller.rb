class SubscriptionController < ApplicationController
  def index
  end

  def create
    Stripe.api_key = Rails.application.credentials.stripe_api_key

    plan_id = 'plan_F5f6vQRhzaVW5t' #params[:plan_id]
    plan = Stripe::Plan.retrieve(plan_id)
    token = params[:stripeToken]

    # product = Stripe::Product.retrieve(Rails.application.credentials.book_library)
    customer = if current_user.stripe_id?
                 Stripe::Customer.retrieve(current_user.stripe_id)
               else
                 Stripe::Customer.create(email: current_user.email, source: token)
               end

    subscription = customer.subscriptions.create(plan: plan.id)

    options = {
      stripe_id: customer.id
    }

    current_user.update(options)
    page = FbPageTemplate.find(params[:fb_page_template_id])
    page.fb_page.update({status: 'online'})
    subs = Subscription.new
    subs.start_date = DateTime.strptime(subscription.current_period_start.to_s,'%s')
    subs.end_date = DateTime.strptime(subscription.current_period_end.to_s,'%s')
    subs.status = "success"
    subs.payment_gateway = "stripe"
    subs.payment_gateway_subscription_id = subscription.id
    subs.user_id = current_user.id
    subs.fb_page_template_id = params[:fb_page_template_id]
    subs.meta_data = subscription
    subs.save!
    redirect_to dashboard_path, notice: " Your subscription was set up successfully!"
  
  end
end
