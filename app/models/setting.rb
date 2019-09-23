# frozen_string_literal: true

class Setting < ApplicationRecord
  belongs_to :fb_page_template
  RESERVED_SUBDOMAINS = %w[www apps support blogs].freeze

  validates :subdomain, presence: true, uniqueness: true
  validates :subdomain, format: /\A[a-z]+[a-z\d\-]*\z/
  validates :subdomain, exclusion: { in: RESERVED_SUBDOMAINS, message: 'That subdomain is not available. Please choose another.' }
end
