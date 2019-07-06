# frozen_string_literal: true

module ApplicationHelper
  def uri?(string)
    uri = URI.parse(string)
    %w( http https ).include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end

  def check_sub_domain
    yield if block_given? && request.subdomain.present? && Fuitter.reserved_subdomains.exclude?(request.subdomain)
  end

  def check_valid_domain
    yield if block_given? && ENV['BASE_URL'].split(',').exclude?(request.domain)
  end
end
