# frozen_string_literal: true

class FbPage < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_one :fb_page_template, dependent: :destroy
  belongs_to :user
end
