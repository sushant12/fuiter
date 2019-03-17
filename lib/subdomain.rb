class Subdomain 
  def matches?(request)
    reserved_subdomain = ['www', 'apps']
    request.subdomain.present? && request.subdomain != 'apps'
  end
end