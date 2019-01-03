class TemplatesController < ApplicationController

  def index
    @page = current_user.fb_pages.find_by(id: params[:fb_page_id])
    @templates = Template.all
  end

  def choose
    FbPageTemplate.find_or_create_by(fb_page_id: params[:fb_page_id]) do |page_template|
      page_template.template_id = params[:template_id]
    end
    redirect_to site_home_path(params[:fb_page_id])
  end
end
