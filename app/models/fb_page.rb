class FbPage < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  belongs_to :template, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
