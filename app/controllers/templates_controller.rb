# frozen_string_literal: true

class TemplatesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @page = current_user.fb_pages.find_by(id: params[:fb_page_id])
    @templates = Template.all
  end

  def choose
    template = FbPageTemplate.find_or_initialize_by(fb_page_id: params[:fb_page_id]) do |tmpl|
      tmpl.pages.new([
                       { title: 'Home', position: 1, uri: 'home' },
                       { title: 'About', position: 2, uri: 'about' },
                       { title: 'Events', position: 3, uri: 'events' },
                       { title: 'Gallery', position: 4, uri: 'gallery' },
                       { title: 'Contact', position: 5,uri: 'contact' },
                       { title: 'News',position: 6, uri: 'news' }
                     ])
      tmpl.fb_page.update(status: 'in progress')
      Facebook::PageDetailService.call(tmpl.fb_page.token)
    end
    template.template_id = params[:template_id]
    template.save!
    redirect_to editor_design_path(params[:fb_page_id])
  end
  
  def properties
    template_properties =  FbPageTemplate.find(params[:id])
    template_properties.properties = params[:template][:properties]
    template_properties.logo = params[:template][:logo]
    template_properties.save!
    render json: {message: "Success"} 
  end
end
