class EditorController < ApplicationController
  TRIAL_PERIOD = 15

  before_action :authenticate_user!, :set_fb_page_template ,:check_trial_period

  def design
    @fb_page_id = params[:fb_page_id]
    # @fb_page_name = FbPage.find_by(id: @fb_page_id).name
    @fb_page_template = FbPageTemplate.find_by(fb_page_id: @fb_page_id)
    # @default_template_value = @fb_page_template.template
    @pages = Page.list_pages(@fb_page_template)
  end

  def list_pages
    template = FbPageTemplate.find_by(fb_page_id: params[:fb_page_id])
    pages = Page.list_pages(template)
    render json: pages
  end

  def page
    # loop thru menu and set menu's parent id(ancestry) to nil in first loop
    # if menu have nested property then assign parent id for them
    page_param[:menu].each_with_index do |menu, index|
      parent = Page.find menu[:id]
      parent.update_attributes(position: index, parent: nil, display: menu['display'])
      unless menu[:nested].empty?
        menu[:nested].each_with_index do |sub_menu, index|
          page = Page.find sub_menu[:id]
          page.update_attributes!(position: index, parent: parent, display: sub_menu['display'])
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
    params.permit(menu: [:id, :title, :display, :position, :seo, :created_at, :updated_at, :fb_page_template_id, :uri, nested: [:id, :title, :display, :position, :seo, :created_at, :updated_at, :fb_page_template_id, :uri]])
  end

  def setting_param
    params.require(:editor).permit(:domain, :subdomain, :fb_page_template_id, :fb_messenger, social_media: {}, legal_info: {})
  end

  def set_fb_page_template
    @fb_page_id = params[:fb_page_id]
    @fb_page_template = FbPageTemplate.find_by(fb_page_id: @fb_page_id)
  end

  def check_trial_period
    trial_exceeded =  @fb_page_template.created_at.to_date + TRIAL_PERIOD > Time.now.to_date
    if trial_exceeded
      flash[:notice] = "Your trial is over. Please upgrade to continue using it"
      redirect_to checkout_url(@fb_page_template.id)
    end
  end
end
