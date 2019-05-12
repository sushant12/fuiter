# frozen_string_literal: true

class SettingDecorator < Draper::Decorator
  delegate_all

  def social_icons
    return [] unless object.social_media.present? 
    object.social_media.select do |name, link|
      link.length > 0 && h.uri?(link)    
    end
    # social_links.map do |name, url|
    #   {
    #     name: name,
    #     url: url
    #   }
    # end        
  end
end
