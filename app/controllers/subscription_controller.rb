# frozen_string_literal: true

class SubscriptionController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :webhook
  before_action :set_fb_page_template, only: %i[create cancel_subscription]

  def new; end

  def create
    plan = Stripe::Plan.retrieve(params[:plan_id])

    customer = find_or_create_customer
    subscription = customer.subscriptions.create(plan: plan.id)

    ActiveRecord::Base.transaction do
      current_user.update!(stripe_id: customer.id)
      @fb_page_template.update!(payment_gateway_subscription_id: subscription.id, subscribed: true)
      @fb_page_template.fb_page.update!(status: 'online')
    end

    redirect_to dashboard_index_path, notice: ' Your subscription was set up successfully!'
  rescue Stripe::CardError, Stripe::InvalidRequestError => e
    redirect_to dashboard_index_path, notice: ' Something went wrong! You are not charged'
  end

  def cancel_subscription
    subscription_id = @fb_page_template.payment_gateway_subscription_id

    customer = Stripe::Customer.retrieve(current_user.stripe_id)

    subscription = customer.subscriptions.retrieve(subscription_id)

    if subscription.delete
      @fb_page.status = 'in progress'
      @fb_page.save
      UserSubscriptionWorker.perform_async(current_user.email, 'remove_subscription')
    end
    render json: {
      page: @fb_page,
      fb_page_template: @fb_page_template,
      customer: customer,
      subscription: subscription
    }
  end

  private

  def set_fb_page_template
    @fb_page = FbPage.find(params[:fb_page_id])
    @fb_page_template = @fb_page.fb_page_template
  end

  def find_or_create_customer
    if current_user.stripe_id?
      Stripe::Customer.retrieve(current_user.stripe_id)
    else
      Stripe::Customer.create(email: current_user.email, source: params[:stripeToken])
   end
  end
end
