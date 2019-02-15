class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page

  def index
  end

  def show
    render json: @page
  end

  def update
    @page.update_attributes(page_param)
    render json: @page
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def page_param
    params.permit(seo: [:metaTags, :metaDescription])
  end
end
