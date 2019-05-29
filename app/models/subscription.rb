class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :fb_page_template

  enum status: [:pending, :failed, :success, :refund]
  enum payment_gateway: [:stripe, :paypal]
end
