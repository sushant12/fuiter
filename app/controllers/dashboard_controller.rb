# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @pages = DashboardDecorator.decorate_collection(current_user.fb_pages.order('fb_pages.status ASC, fb_pages.updated_at DESC'))
  end
end
