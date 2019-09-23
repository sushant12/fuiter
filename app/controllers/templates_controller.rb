# frozen_string_literal: true

class TemplatesController < ApplicationController
  before_action :authenticate_user!

  def index
    @page = current_user.fb_pages.find_by(id: params[:fb_page_id])
    @templates = Template.all
  end

  def choose
    if FbPageTemplate.exists?(fb_page_id: params[:fb_page_id])
      fb_page_template = FbPageTemplate.find_by(fb_page_id: params[:fb_page_id])
      fb_page_template.update(template_id: params[:template_id])
    else
      template_properties = Template.find(params[:template_id]).properties
      fb_page = FbPage.find(params[:fb_page_id])
      ActiveRecord::Base.transaction do
        fb_page_template = fb_page.build_fb_page_template(template_id: params[:template_id])
        fb_page_template.pages.build(template_properties['pages'])
        fb_page_template.save!
        fb_page.update(status: 'in progress')
        Facebook::PageDetailService.call(fb_page.token)
      end
    end

    unless Setting.exists?(fb_page_template_id: fb_page_template.id)
      page_name = FbPage.find(params[:fb_page_id]).name
      setting = fb_page_template.create_setting(subdomain: page_name.downcase.gsub(/[^0-9A-Za-z]/, ''))
    end

    redirect_to editor_design_path(params[:fb_page_id])
  end

  def properties
    template_properties = FbPageTemplate.find(params[:id])
    template_properties.remove_logo! if params[:template][:logo] == ''
    template_properties.remove_favicon! if params[:template][:favicon] == ''
    template_properties.update(fb_page_template_param[:template])
    render json: template_properties
  end

  private

  def fb_page_template_param
    params.permit(template: [:title, :logo, :favicon, properties: [theme: %i[font color]]])
  end
end
