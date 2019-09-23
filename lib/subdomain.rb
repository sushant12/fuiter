# frozen_string_literal: true

class Subdomain
  def matches?(request)
    if request.subdomain.present? && Fuitter.reserved_subdomains.exclude?(request.subdomain)
      true
    else
      ENV['BASE_URL'].split(',').exclude?(request.domain)
    end
  end
end
