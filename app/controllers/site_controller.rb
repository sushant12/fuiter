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
    valid_sub_domain = helpers.check_sub_domain do
      Setting.find_by(subdomain: request.subdomain).fb_page_template.fb_page.decorate
    end
    valid_domain = helpers.check_valid_domain do
      Setting.find_by(domain: request.domain).fb_page_template.fb_page.decorate
    end

    @page = valid_sub_domain || valid_domain || FbPage.find_by(id: params[:fb_page_id]).decorate
    @template = @page.fb_page_template.decorate
    @template_setting = template_setting.decorate
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

  def template_setting
    Setting.find_by(fb_page_template_id: @template.id)
  end
end
