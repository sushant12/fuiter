# frozen_string_literal: true

class Page < ApplicationRecord
  mount_uploader :about_image, AboutUploader
  attribute :nested
  has_ancestry
  belongs_to :fb_page_template

  def self.list_pages(fb_page_template)
    fb_page_template.pages.order(:position).select do |page|
      page['nested'] = page.children if page.parent.nil?
    end
  end
end
