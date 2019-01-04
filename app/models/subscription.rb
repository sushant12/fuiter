class Subscription < ApplicationRecord
  belongs_to :fb_page, dependent: :destroy
end
