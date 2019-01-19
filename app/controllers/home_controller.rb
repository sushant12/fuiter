# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.fb_pages.empty?
      PageService.call(
        access_token: current_user.token,
        user: current_user
      )
    end
    @pages = HomeDecorator.decorate_collection(current_user.fb_pages)
  end

  def sync
    PageService.call(
      access_token: current_user.token,
      user: current_user
    )
    redirect_to root_path
  end
end
