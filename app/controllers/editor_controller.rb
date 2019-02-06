# frozen_string_literal: true

class EditorController < ApplicationController
  def design
    @fb_page_id = params[:fb_page_id]
    @template = FbPageTemplate.find_by(fb_page_id: @fb_page_id)
  end

  def page
    @fb_page_id = params[:fb_page_id]
    fb_page_template = FbPageTemplate.find_by(fb_page_id: @fb_page_id)
    fb_page_template.pages = page_param[:menu]
    fb_page_template.save!
  end

  def setting; end

  private

  def page_param
    params.permit(menu: [:id, :title, :position, :seo, :created_at, :updated_at, :fb_page_template_id, :uri, nested: [:id, :title, :position, :seo, :created_at, :updated_at, :fb_page_template_id, :uri]])
  end
end
