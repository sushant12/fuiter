class BillingController < ApplicationController
  def index
    @pages = current_user.fb_pages
  end

  def billing_history
    fb_page_template_id = FbPage.find(params[:fb_page_id]).fb_page_template.id
    render json: Subscription.where(fb_page_template_id: fb_page_template_id)
  end
end
