class SiteController < ApplicationController
  layout :template_layout
  before_action :set_fb_page

  def home
    # render json: @page.content
    render template: "#{template_layout}/home"
  end

  def about
    render template: "#{template_layout}/about"
  end

  def contact
    render template: "#{template_layout}/contact"
  end

  def events
    render template: "#{template_layout}/events"
  end

  def gallery
    render template: "#{template_layout}/gallery"
  end

  def news
    render template: "#{template_layout}/news"
  end

  def send_contact_message
    
  end

  private

  def set_fb_page
    @page = FbPage.find_by(id: params[:fb_page_id]).decorate
  end

  def template_layout
    name = @page.fb_page_template.template.name
    "templates/#{name}"
  end
end
