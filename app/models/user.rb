class User < ApplicationRecord
  has_many :fb_pages, dependent: :destroy
end
