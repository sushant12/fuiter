# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @pages = HomeDecorator.decorate_collection(current_user.fb_pages)
  end

  def sync
    fb_page = FbPage.find(params[:id])
    Facebook::PageDetailService.call(fb_page.token)
    redirect_back(fallback_location: root_path)
  end
end
