# frozen_string_literal: true

class SettingDecorator < Draper::Decorator
  delegate_all

  def template_social_icons
    object.socail_media['social'].each do |url|      
      if (!url['name'].include? 'http') && (url['name'].length > 0)
        url['name'] = 'http://' + url['name']
      end
    end        
  end
end
