class HomesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if current_user.token
      PageService.call(
        access_token: current_user.token,
        user: current_user
        )
    end
  end
end
