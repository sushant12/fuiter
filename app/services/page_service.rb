class PageService < ApplicationService

  def initialize(access_token:, user:)
    @fb = Facebook::Page.new(
      access_token: access_token
    )
    @current_user = user
  end

  def call
    pages = @fb.list
    pages['accounts']['data'].each do |page|
      fb_page = Facebook::Page.new(
        access_token: element['access_token']
      )
      content = fb_page.get_info
      @current_user.fb_pages.create!(fb_page_id: page['id'], name: page['name'], token: page['access_token'], content: content)
    end
  end
end