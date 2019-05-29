# frozen_string_literal: true

class FbPageTemplate < ApplicationRecord
  belongs_to :fb_page
  belongs_to :template
  has_many :pages, dependent: :destroy
  has_many :subscriptions
  has_one :setting, dependent: :destroy

  mount_uploader :logo, LogoUploader
  mount_uploader :favicon, FavicoUploader
end
