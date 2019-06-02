class SubscriptionController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :webhook
  def index
  end

  def create
    page = FbPageTemplate.find(params[:fb_page_template_id])
    Stripe.api_key = Rails.application.credentials.stripe_api_key

    plan_id = 'plan_FAjGZfXAcVNBK0' #params[:plan_id]
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
    UserSubscribeMailer.user_subscribe(current_user).deliver
    page.update({payment_gateway_subscription_id: subscription.id})

    page.fb_page.update({status: 'online'})
    redirect_to dashboard_path, notice: " Your subscription was set up successfully!"

  end
end
