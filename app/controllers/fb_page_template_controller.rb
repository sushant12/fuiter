class FbPageTemplateController < ApplicationController
  before_action :authenticate_user!
  def show
    render json: Page.find(params[:id]).fb_page_template
  end

  def update
    template = Page.find(params[:id]).fb_page_template
    template.update_attributes!(template_param)
    render json: template
  end

  private

  def template_param
    params.permit(:email, :location, :contact, :email_enable, :location_enable, :contact_enable, :map_enable)
  end
end
