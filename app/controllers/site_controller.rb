class SiteController < ApplicationController
  layout "templates/ucorpora"

  def home
    @page = FbPage.find_by(id: params[:fb_page_id]).decorate
    # render json: @page.content

    render template: "templates/ucorpora/home"
  end

  def about
  end

  def contact
  end

  def events
  end

  def gallery
  end

  def news
  end
end
