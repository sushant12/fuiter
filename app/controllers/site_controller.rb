class SiteController < ApplicationController
  layout "templates/ucorpora"

  def home
    @page = FbPage.find_by(id: "91087338-4e93-41a7-a76d-c59cf2709479")
    @sliders = @page.content['albums']['data'].select do |slider|
      slider['name'] == "Cover Photos"
    end
    # binding.pry
    @abc = @sliders.first["photos"]["data"].select do |a|
      a["images"].first
    end
    # binding.pry

    # binding.pry
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
