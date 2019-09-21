# frozen_string_literal: true

class FbPageDecorator < Draper::Decorator
  delegate_all

  def home_menu
    sub_domain_and_domain_checker || h.site_home_url(object.id) 
  end

  def about_menu
    sub_domain_and_domain_checker('about') || h.site_about_url(object.id)
  end

  def events_menu
    sub_domain_and_domain_checker('events') ||  h.site_events_url(object.id)
  end

  def contact_menu
    sub_domain_and_domain_checker('contact') || h.site_contact_url(object.id)
  end

  def gallery_menu
    sub_domain_and_domain_checker('gallery') || h.site_gallery_url(object.id)
  end

  def news_menu
    sub_domain_and_domain_checker('news') || h.site_news_url(object.id)
  end

  def photos_menu(album_id)
    if h.request.subdomain.present? && Fuitter.reserved_subdomains.exclude?(h.request.subdomain)
      "http://#{h.request.subdomain}.#{h.request.domain}:#{h.request.port}/gallery/#{album_id}"
    elsif ENV['BASE_URL'].split(",").exclude? h.request.domain 
      "http://#{h.request.domain}:#{h.request.port}/gallery/#{album_id}"
    else
      h.site_photo_albums_url(object.id, album_id)
    end
  end

  def privacy_policy_menu
    sub_domain_and_domain_checker('privacy_policy') ||  h.site_privacy_policy_url(object.id)
  end

  def terms_and_cond_menu
    sub_domain_and_domain_checker('terms_and_condition') ||  h.site_terms_condition(object.id)
  end

  def menu
     Page.list_pages(object.fb_page_template)
  end

  def cover_images
    albums = object.content.dig('albums', 'data')&.select do |album|
      album['name'] == 'Cover Photos'
    end
    if albums.empty?
      object.fb_page_template.template.properties.dig('slider')
    else
      albums.first.dig('photos', 'data').map do |img|
        img['images'].first
      end
    end
  end

  def name
    object.content.dig('name')
  end

  def contact
    contact = object.fb_page_template
    phone = contact.contact_enable ? contact.contact :  object.content.dig('phone')
    email = contact.email_enable ? contact.email : object.content.dig('emails')&.first
    city = object.content.dig('location', 'city')
    street = object.content.dig('location', 'street')
    address = contact.location_enable ? contact.location : "#{city}, #{street}" 
    {
      'phone' => phone,
      'email' => email,
      'address' => address,
    }
  end

  def albums
    albums = object.content.dig('albums', 'data')
    albums = albums.select { |album| album['photo_count'] > 0 }
    albums.map do |album|
      preview = photos(album.dig('id')).first.first.dig('source')
      {
        'preview' => preview,
        'id' => album.dig('id'),
        'name' => album.dig('name')
      }
    end
  end

  def about
    about = object.fb_page_template.pages.where("uri = 'about'").first
    show_custom_description = about.setting.dig('description', 'enable').to_s
    if show_custom_description == 'true'
      about.setting.dig('description', 'value')
    else
      object.content.dig('about')
    end
  end

  def description
    home = object.fb_page_template.pages.where("uri = 'home'").first
    show_custom_description = home.setting.dig('description', 'enable').to_s
    if show_custom_description == 'true'
      home.setting.dig('description', 'value')
    else
      object.content.dig('description')
    end
  end

  def about_image
    about = object.fb_page_template.pages.where("uri = 'about'").first
    if about.setting.dig('image', 'enable') == 'true'
      about.about_image.url
    else
      object.picture
    end
  end

  def posts
    posts = object.content.dig('posts', 'data')
    posts = posts.nil? ? [] : posts
    posts.map do |post|
      {
        'message' => post.dig('message'),
        'image' => post.dig('full_picture'),
        'created_at' => post.dig('created_time')&.to_date&.to_s,
        'name' => post.dig('name'),
        'description' => post.dig('description'),
        'video' => post.dig('source')
      }
    end
  end

  def events
    events = object.content.dig('events', 'data')
    events = events.nil? ? [] : events
    events.map do |event|
      {
        'image' => event.dig('cover', 'source'),
        'name' => event.dig('name'),
        'location' => event.dig('place'),
        'description' => event.dig('description'),
        'date' => event['start_time'].to_date,
        'start_time' => event['start_time']&.to_time&.strftime("%I:%M %p"),
        'end_time' => event['end_time']&.to_time&.strftime("%I:%M %p"),
        'event_times' => event.dig("event_times"),
      }
    end
  end

  def description
    home = object.fb_page_template.pages.where("uri = 'home'").first
    show_custom_description = home.setting.dig('description', 'enable').to_s
    if show_custom_description == 'true'
      home.setting.dig('description', 'value')
    else
      object.content.dig('description')
    end
  end

  def photos(album_id)
    albums = object.content.dig('albums', 'data')
    albums = albums.nil? ? [] : albums
    album_ids = albums.select do |album|
      album['id'] == album_id
    end
    album_ids.first.dig('photos', 'data')&.map do |photo|
      photo['images']
    end
  end

  private

  def sub_domain_and_domain_checker(page = '')
    url_wtih_sub_domain = h.check_sub_domain {
                        "http://#{h.request.subdomain}.#{h.request.domain}:#{h.request.port}/#{page}"
                       }
    url_with_domain = h.check_valid_domain {
                    "http://#{h.request.domain}:#{h.request.port}/#{page}"
                  }
    url_wtih_sub_domain || url_with_domain
  end
end
