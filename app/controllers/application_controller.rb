# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_raven_context

  def after_sign_in_path_for(_resource)
    dashboard_index_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end

  def authenticate_admin!
    redirect_to new_user_session_path unless current_user&.admin
  end

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
