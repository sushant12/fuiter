# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :fb_page, dependent: :destroy
end
