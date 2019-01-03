class SyncFbPage < ApplicationService

  def initialize(access_token:, user:)
    @pages = Facebook::Page.new(
      access_token: access_token
    )
    @current_user = user
  end

  def call
    data = @pages.list
    user_id = @current_user.id
    
    @current_user.fb_pages.each do |page|
      data['accounts']['data'].each do |element|
        if page.fb_page_id  === element['id']
          page.update(name: element['name'], token: element['access_token'])
        # else 
        #   FbPage.create(fb_page_id: element['id'], name: element['name'], token: element['access_token'], user_id: user_id)
        end
      end
    end
  end
end