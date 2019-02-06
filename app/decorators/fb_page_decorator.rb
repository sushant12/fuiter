# frozen_string_literal: true

class FbPageDecorator < Draper::Decorator
  delegate_all

  def menu
     Page.list_pages(object.fb_page_template)
     # .pages.order(:position).map do |page|
     #  {
     #    'name' => page.title,
     #    'uri' => page.uri
     #  }
    # end
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
    {
      'city' => object.content.dig('location', 'city'),
      'country' => object.content.dig('location', 'country')
    }
  end

  def albums
    object.content.dig('albums', 'data').map do |album|
      {
        'preview' => photos(album.dig('id')).first.first.dig('source'),
        'id' => album.dig('id'),
        'name' => album.dig('name')
      }
    end
  end

  def about
    object.content.dig('about')
  end

  def posts
    object.content.dig('posts', 'data').map do |posts|
      {
        'message' => posts.dig('message'),
        'image' => posts.dig('full_picture'),
        'created_at' => posts.dig('created_time').to_date.to_s,
        'name' => posts.dig('name'),
        'description' => posts.dig('description'),
        'video' => posts.dig('source')
      }
    end
  end

  def events
    object.content.dig('events', 'data').map do |event|
      {
        'image' => event.dig('cover', 'source'),
        'name' => event.dig('name'),
        'location' => event.dig('place'),
        'description' => event.dig('description'),
        'date' => event['start_time'].to_date,
        'start_time' => event['start_time'].to_time.strftime("%I:%M %p"),
        'end_time' => event['end_time'].to_time.strftime("%I:%M %p"),
        'event_times' => event.dig("event_times"),
      }
    end
  end

  def description
    object.content.dig('description')
  end

  def photos(album_id)
    albums = object.content.dig('albums', 'data').select do |album|
      album['id'] == album_id
    end
    albums.first.dig('photos', 'data').map do |photo|
      photo['images']
    end
  end
end
