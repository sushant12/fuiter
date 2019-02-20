class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page

  def index
  end

  def show
    render json: @page
  end

  def update
    binding.pry
    @page.remove_about_image! if params[:about_image] == ''
    @page.update_attributes(page_param)
    render json: @page
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def page_param
    params.permit(:title, :about_image, seo: [:metaTags, :metaDescription], setting: [description: [:value, :enable], image: [:enable]])
  end
end
