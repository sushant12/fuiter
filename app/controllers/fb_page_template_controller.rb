class FbPageTemplateController < ApplicationController
  before_action :authenticate_user!
  def show
    render json: FbPageTemplate.find(params[:id])
  end

  def update
    template = FbPageTemplate.find(params[:id])
    template.update_attributes!(template_param)
    render json: template
  end

  private

  def template_param
    params.permit(:email, :location, :contact, :email_enable, :location_enable, :contact_enable, :map_enable, properties: [theme: [:font, :color]])
  end
end
