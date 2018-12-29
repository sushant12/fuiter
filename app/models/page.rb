class Page < ApplicationRecord
  belongs_to :template, dependent: :destroy
end
