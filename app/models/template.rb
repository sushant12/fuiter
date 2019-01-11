# frozen_string_literal: true

class Template < ApplicationRecord
  belongs_to :fb_page_template, optional: true
  validates :name, uniqueness: true
end
