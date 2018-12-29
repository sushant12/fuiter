class Template < ApplicationRecord
  belongs_to :fb_page, dependent: :destroy
  has_many :pages, dependent: :destroy
  belongs_to:setting, dependent: :destroy

end
