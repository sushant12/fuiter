# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :fb_page_template

  enum status: %i[pending failed success refund]
  enum payment_gateway: %i[stripe paypal]
end
