# frozen_string_literal: true

class SiteController < ApplicationController
  layout :template_layout
  before_action :set_fb_page

  def home
    set_seo
    render template: "#{template_layout}/home"
  end

  def about
    set_seo
    render template: "#{template_layout}/about"
  end

  def contact
    set_seo
    render template: "#{template_layout}/contact"
  end

  def send_contact_message
    @user_query = params[:contact]
    ContactMailer.notify_user(@user_query).deliver
    ContactMailer.notify_admin(@user_query).deliver
  end

  def events
    set_seo
    render template: "#{template_layout}/events"
  end

  def gallery
    set_seo
    render template: "#{template_layout}/gallery"
  end

  def news
    set_seo
    render template: "#{template_layout}/news"
  end

  def photo_albums
    @album_id = params[:album_id]
    render template: "#{template_layout}/photos"
  end

  def terms_condition
    @page_setting = find_setting
    render template: "#{template_layout}/terms_condition"
  end

  def privacy_policy
    @page_setting = find_setting
    render template: "#{template_layout}/privacy_policy"
  end

  private

  def set_fb_page
    reserved_subdomain = ['www', 'apps']
    if request.subdomain.present? && !reserved_subdomain.include?(request.subdomain)
      @page = Setting.find_by(subdomain: request.subdomain).fb_page_template.fb_page.decorate
    elsif request.domain != ENV['BASE_URL']
      @page = Setting.find_by(domain: request.domain).fb_page_template.fb_page.decorate
    else
      @page = FbPage.find_by(id: params[:fb_page_id]).decorate
    end
    @template = @page.fb_page_template
    unless find_setting.nil?
      @editor_setting = find_setting.decorate
    end
  end

  def set_seo
    current_action = caller[0][/`.*'/][1..-2]
    page = @page.fb_page_template.pages.find do |menu| 
      menu.uri == current_action
    end
    @seo = page.seo
  end

  def template_layout
    name = @page.fb_page_template.template.name
    "templates/#{name}"
  end

  def find_setting
    Setting.find_by(fb_page_template_id: @template.id)
  end
end
