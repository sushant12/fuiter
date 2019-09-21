# frozen_string_literal: true

class DashboardDecorator < ApplicationDecorator
  delegate_all

  def facebook_page_id
    object.content.dig('id')
  end

  def state
    {
      'online' => { type: 'online', value: 'Online' },
      'in progress' => { type: 'in-progress', value: 'In Progress' },
      'expired' => { type: 'expired', value: 'Expired' }
    }
  end
end
