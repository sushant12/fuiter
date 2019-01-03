class HomesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if fb_page_exits
      PageService.call(
        access_token: current_user.token,
        user: current_user,
        )
    end
    @pages = current_user.fb_pages
  end

  def sync
    SyncFbPage.call(
      access_token: current_user.token,
      user: current_user,
    )
    redirect_to action: "index"
  end

  private
  
  def fb_page_exits
    current_user.token && current_user.fb_pages.empty?
  end
end
