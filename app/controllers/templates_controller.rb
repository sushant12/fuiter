class TemplatesController < ApplicationController

  def index
    @page = current_user.fb_pages.find_by(id: params[:fb_page_id])
    @templates = Template.all
  end
end
