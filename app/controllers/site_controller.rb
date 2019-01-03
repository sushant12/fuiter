class SiteController < ApplicationController
  layout "templates/ucorpora"

  def home
    @page = FbPage.find_by(id: params[:fb_page_id]).decorate
    # render json: @page.content
    render template: "templates/ucorpora/home"
  end

  def about
    @page = FbPage.find_by(id: params[:fb_page_id]).decorate
    # render json: @page.content
    render template: "templates/ucorpora/about"
  end

  def contact
    @page = FbPage.find_by(id: params[:fb_page_id]).decorate
    # render json: @page.content
    render template: "templates/ucorpora/contact"
  end

  def events
    @page = FbPage.find_by(id: params[:fb_page_id]).decorate
    # render json: @page.content
    render template: "templates/ucorpora/events"
  end

  def gallery
    @page = FbPage.find_by(id: params[:fb_page_id]).decorate
    # render json: @page.content
    render template: "templates/ucorpora/gallery"
  end

  def news
    @page = FbPage.find_by(id: params[:fb_page_id]).decorate
    # render json: @page.content
    render template: "templates/ucorpora/news"
  end
end
