class PageService < ApplicationService

  def initialize(access_token:, user:)
    @pages = Facebook::Page.new(
      access_token: access_token,
      user: user
    )
  end

  def call
    data=@pages.list
    user_id = @pages.user.id
    data['accounts']['data'].each do |element|
        FbPage.create(fb_page_id: element['id'], name: element['name'], token: element['access_token'], user_id: user_id)
      end
    end
  end
end