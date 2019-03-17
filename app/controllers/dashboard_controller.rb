# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @pages = DashboardDecorator.decorate_collection(current_user.fb_pages.order('fb_pages.status ASC, fb_pages.updated_at DESC'))
  end

  def sync
    fb_page = FbPage.find(params[:id])
    Facebook::PageDetailService.call(fb_page.token)
    redirect_back(fallback_location: root_path)
  end
end
