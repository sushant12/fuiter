# frozen_string_literal: true

class TemplatesController < ApplicationController
  before_action :authenticate_user!

  def index
    @page = current_user.fb_pages.find_by(id: params[:fb_page_id])
    @templates = Template.all
  end

  def choose
    template = FbPageTemplate.find_or_initialize_by(fb_page_id: params[:fb_page_id]) do |tmpl|
      template_properties = Template.find(params[:template_id]).properties
      tmpl.pages.new(template_properties['pages'])
      tmpl.fb_page.update(status: 'in progress')
      Facebook::PageDetailService.call(tmpl.fb_page.token)
    end
    template.template_id = params[:template_id]
    template.save!
    page_name = FbPage.find(params[:fb_page_id]).name
    settings = Setting.find_or_initialize_by(fb_page_template_id: template.id) do |setting|
      setting.subdomain = page_name.downcase.gsub(/[^0-9A-Za-z]/, '')
    end
    settings.save!
    redirect_to editor_design_path(params[:fb_page_id])
  end
  
  def properties
    template_properties = FbPageTemplate.find(params[:id])
    template_properties.remove_logo! if params[:template][:logo] == ''
    template_properties.remove_favicon! if params[:template][:favicon] == ''
    template_properties.update_attributes(fb_page_template_param[:template])
    render json: template_properties
  end

  private

  def fb_page_template_param
    params.permit(template: [:title, :logo, :favicon, properties: [body: [:font, :bg_color, :font_size, :font_color], nav: [ :bg_color, :hover_color, :font_color, :font, :font_size]] ])
  end
end
