class BillingController < ApplicationController
  def index
    @bills = current_user.subscriptions
  end
end
