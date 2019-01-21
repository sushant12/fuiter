# frozen_string_literal: true

class Facebook::PageDetailService < ApplicationService

  def initialize(access_token)
    @page = Facebook::Page.new(access_token)
  end

  def call
    save_page_info
  rescue => e
    Raven.capture_exception(e)
  end

  private

  def save_page_info
    content = @page.get_info
    fb_page = FbPage.find_by(fb_page_id: content['id'])
    fb_page.content = content
    fb_page.save!
  end
end
