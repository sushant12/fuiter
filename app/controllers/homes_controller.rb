# frozen_string_literal: true

class HomesController < ApplicationController
  before_action :authenticate_user!

  def index
    if fb_page_exist
      PageService.call(
        access_token: current_user.token,
        user: current_user
      )
    end
    @pages = current_user.fb_pages
  end

  def sync
    PageService.call(
      access_token: current_user.token,
      user: current_user
    )
    redirect_to root_path
  end

  private

  def fb_page_exist
    current_user.token && current_user.fb_pages.empty?
  end
end
