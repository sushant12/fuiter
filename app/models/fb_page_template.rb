# frozen_string_literal: true

class FbPageTemplate < ApplicationRecord
  belongs_to :fb_page
  belongs_to :template
  has_one :setting, dependent: :destroy

  mount_uploader :logo, LogoUploader
end
