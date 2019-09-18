# frozen_string_literal: true

class FbPage < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_one :fb_page_template, dependent: :destroy
  accepts_nested_attributes_for :fb_page_template, :allow_destroy => false

  belongs_to :user
  enum status: {
    'online': 'online',
    'in progress': 'in progress', 
    'expired': 'expired'
  }
end
