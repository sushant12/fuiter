class TemplatesController < ApplicationController

  def index
    @page = current_user.fb_pages.find_by(id: params[:fb_page_id])
    @templates = Template.all
  end

  def choose
    template = FbPageTemplate.find_or_initialize_by(fb_page_id: params[:fb_page_id]) do |tmpl|
      tmpl.pages.new([
      {title: "Home", uri: 'home'},
      {title: "About", uri: 'about'},
      {title: "Events", uri: 'events'},
      {title: "Gallery", uri: 'gallery'},
      {title: "Contact", uri: 'contact'},
      {title: "News", uri: 'news'},
    ])
    end
    template.template_id = params[:template_id]
    template.save!
    redirect_to site_home_path(params[:fb_page_id])
  end
end
