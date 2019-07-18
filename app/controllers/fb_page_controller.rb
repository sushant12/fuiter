class FbPageController < ApplicationController
  before_action :authenticate_user!

  def sync
    fb_page = FbPage.find(params[:fb_page_id])
    synced_fb_page = Facebook::PageDetailService.call(fb_page.token)
    render json: {
      message: synced_fb_page
    },
    status: 200
  end
end
