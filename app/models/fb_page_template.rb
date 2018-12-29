class FbPageTemplate < ApplicationRecord
  belongs_to :fb_pages
  belongs_to :templates
  has_many :pages, dependent: :destroy
  has_one :setting, dependent: :destroy
end
