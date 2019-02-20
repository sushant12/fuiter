class Page < ApplicationRecord
  mount_uploader :about_image, AboutUploader
  attribute :nested
  has_ancestry
  belongs_to :fb_page_template


  def self.list_pages(fb_page_template)
    fb_page_template.pages.order(:position).select do |page|
      if page.parent.nil?
        page['nested'] = page.children
      end
    end
  end
end