class Subscription < ApplicationRecord
  belongs_to :fb_page
  belongs_to :plan
end
