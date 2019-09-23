# frozen_string_literal: true

class FbPageTemplateDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def body_design
    "color: #{object.properties.dig('body', 'font_color')}; font-size: #{object.properties.dig('body', 'font_size')}px; "
  end

  def nav_design
    "color: #{object.properties.dig('nav', 'font_color')}; font-size: #{object.properties.dig('nav', 'font_size')}px; font-family: #{object.properties.dig('nav', 'font')};"
  end
end
