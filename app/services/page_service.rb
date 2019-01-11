# frozen_string_literal: true

class PageService < ApplicationService
  def initialize(access_token:, user:)
    @fb = Facebook::Page.new(
      access_token: access_token
    )
    @current_user = user
  end

  def call
    accounts = @fb.list
    accounts['accounts']['data'].each do |account|
      page = Facebook::Page.new(
        access_token: account['access_token']
      )
      content = page.get_info
      fb_page = @current_user.fb_pages.find_or_initialize_by(fb_page_id: account['id'])
      fb_page.name = account['name']
      fb_page.token = account['access_token']
      fb_page.content = content
      fb_page.save!
    end
  end
end
