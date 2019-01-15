# frozen_string_literal: true

class EditorController < ApplicationController
  def design
    @fb_page_id = params[:fb_page_id]
    @template = FbPageTemplate.find_by(fb_page_id: @fb_page_id)
  end

  def page; end

  def setting; end
end
