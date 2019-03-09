# frozen_string_literal: true

class FbPageDecorator < Draper::Decorator
  delegate_all

  def menu
     Page.list_pages(object.fb_page_template)
  end

  def cover_images
    albums = object.content.dig('albums', 'data').select do |album|
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

  def address
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
    # binding.pry
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
end
