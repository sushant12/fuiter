# frozen_string_literal: true

class EditorController < ApplicationController
  before_action :authenticate_user!
  
  def design
    @fb_page_id = params[:fb_page_id]
    @template = FbPageTemplate.find_by(fb_page_id: @fb_page_id)
    @pages = Page.list_pages(@template)
    # @pages = @template.pages.order(:position).select do |page|
    #   if page.parent.nil?
    #     page['nested'] = page.children
    #   end
    # end
  end

  def page
    # loop thru menu and set menu's parent id(ancestry) to nil in first loop
    # if menu have nested property then assign parent id for them  
    page_param[:menu].each_with_index do |menu, index|
      parent = Page.find menu[:id]
      parent.update_attributes(position: index, parent: nil)
      unless menu[:nested].empty?
        menu[:nested].each_with_index do |sub_menu, index|
          page = Page.find sub_menu[:id]
          page.update_attributes!(position: index, parent: parent) 
        end
      end
    end
  end

  def setting; end

  private

  def page_param
    params.permit(menu: [:id, :title, :position, :seo, :created_at, :updated_at, :fb_page_template_id, :uri, nested: [:id, :title, :position, :seo, :created_at, :updated_at, :fb_page_template_id, :uri]])
  end
end
