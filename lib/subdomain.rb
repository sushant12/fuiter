class Subdomain 
  def matches?(request)
    reserved_subdomain = ['www', 'apps']
    if request.subdomain.present? && !reserved_subdomain.include?(request.subdomain)
      true
    else
      request.domain != ENV['BASE_URL']
    end
  end
end