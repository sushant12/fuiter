# frozen_string_literal: true

class Page < ApplicationRecord
  belongs_to :fb_page_template
  has_many :sub_page
end
