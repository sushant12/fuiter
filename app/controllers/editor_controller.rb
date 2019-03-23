class EditorController < ApplicationController
  before_action :authenticate_user!
  
  def design
    @fb_page_id = params[:fb_page_id]
    @fb_page_name = FbPage.find_by(id: @fb_page_id).name
    @template = FbPageTemplate.find_by(fb_page_id: @fb_page_id)
    @pages = Page.list_pages(@template)
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

  def create_setting
    editor_setting = Setting.find_or_initialize_by(fb_page_template_id: params[:fb_page_template_id])
    editor_setting.attributes = setting_param
    editor_setting.save!
    render json: editor_setting
  end

  def show_setting
    editor_setting = Setting.find_by(fb_page_template_id: params[:fb_page_template_id])
    render json: editor_setting
  end

  private

  def page_param
    params.permit(menu: [:id, :title, :position, :seo, :created_at, :updated_at, :fb_page_template_id, :uri, nested: [:id, :title, :position, :seo, :created_at, :updated_at, :fb_page_template_id, :uri]])
  end

  def setting_param
    params.require(:editor).permit(:domain, :subdomain, :fb_page_template_id, socail_media: {}, legal_info: {})
  end
end
