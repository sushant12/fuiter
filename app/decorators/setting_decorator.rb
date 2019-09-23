# frozen_string_literal: true

class SettingDecorator < Draper::Decorator
  delegate_all

  def social_icons
    return [] if object.social_media.blank?

    object.social_media.select do |_name, link|
      !link.empty? && h.uri?(link)
    end
    # social_links.map do |name, url|
    #   {
    #     name: name,
    #     url: url
    #   }
    # end
  end
end
