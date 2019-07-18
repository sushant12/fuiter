class SubscriptionController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :webhook
  def new
  end

  def create
    fb_page = FbPage.find(params[:fb_page_id])
    page = fb_page.fb_page_template
    Stripe.api_key = Fuitter.credentials[:stripe_api_key]

    plan_id = params[:plan_id]
    plan = Stripe::Plan.retrieve(plan_id)
    token = params[:stripeToken]

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
    page.update({payment_gateway_subscription_id: subscription.id})

    page.fb_page.update({status: 'online'})
    redirect_to dashboard_path, notice: " Your subscription was set up successfully!"

  end

  def cancel_subscription
    page = FbPage.find(params[:fb_page_id])
    fb_page_template = page.fb_page_template
    subscription_id = fb_page_template.payment_gateway_subscription_id
    Stripe.api_key = Fuitter.credentials[:stripe_api_key]
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    subscription = customer.subscriptions.retrieve(subscription_id).delete
    page.status = "in progress"
    page.save
    render json: {
      page: page,
      fb_page_template: fb_page_template,
      customer: customer,
      subscription: subscription
    }
  # rescue

  end
end
