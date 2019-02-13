class HomeDecorator < ApplicationDecorator
  delegate_all
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def facebook_page_id
    object.content.dig('id')
  end

  def state
    case self.status
      when "online"
        "success"
      when "in progress"
        "info"
      when "expired"
        "danger"
      else
        ""
      end
  end
end
