# frozen_string_literal: true

class SettingDecorator < Draper::Decorator
  delegate_all

  def social_icons
    return [] unless object.social_media.present? 
    social_links = object.social_media['social'].select do |social|
      social['name'].length > 0 && h.uri?(social['name'])    
    end

    social_links.map do |social|
      {
        url: social["name"],
        icon: social["icon"],
      }
    end        
  end
end
