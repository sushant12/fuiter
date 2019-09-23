# frozen_string_literal: true

class Facebook::PageDetailService < ApplicationService
  def initialize(access_token)
    @page = Facebook::Page.new(access_token)
  end

  def call
    save_page_info
  rescue StandardError => e
    Raven.capture_exception(e)
  end

  private

  def save_page_info
    content = @page.get_info
    unless content.dig('location', 'latitude')
      address = "#{content.dig('location', 'street')}, #{content.dig('location', 'city')}, #{content.dig('location', 'country')}"
      latitude, longitude = geocode_address(address)
      content['location']['latitude'] = latitude
      content['location']['longitude'] = longitude
    end
    fb_page = FbPage.find_by(fb_page_id: content['id'])
    fb_page.content = content
    fb_page.save!
    fb_page
  end

  def geocode_address(address)
    location = Geocoder.search(address)
    location.first.coordinates unless location.empty?
  end
end
