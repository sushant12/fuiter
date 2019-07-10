# frozen_string_literal: true

class Facebook::PageRequestService < ApplicationService

  def initialize(user)
    @fb = Facebook::Page.new(user.token)
    @user = user
  end

  def call
    accounts = @fb.list
    accounts['accounts']['data'].each { |account| save_page(account) }
  rescue => e
    Raven.capture_exception(e)
  end

  private

  def save_page(account)
    @user.fb_pages.where(fb_page_id: account['id']).first_or_create do |fb_page| 
      fb_page.name = account['name']
      fb_page.token = account['access_token']
      fb_page.picture = account['picture']['data']['url']
      fb_page.category = account['category']
    end
  end
end
