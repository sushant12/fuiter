class Setting < ApplicationRecord
  belongs_to :template, dependent: :destroy
end
