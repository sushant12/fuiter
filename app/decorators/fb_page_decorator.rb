class FbPageDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def menu
    object.fb_page_template.pages.map do |page|
      {
        "name" => page.title,
        "uri" => page.uri
      }
    end
  end
  def cover_images
    albums = object.content['albums']['data'].select do |album|
      album['name'] == "Cover Photos"
    end
    if albums.empty?
      object.fb_page_template.template.properties["slider"]
    else
      albums.first["photos"]["data"].map do |img|
        img["images"].first
      end
    end
  end

  def name
    object.content['name']
  end

  def address
    object.content['location']
  end

  def albums
    object.content['albums']['data'].map do |album|
      {
        "album_photos" => photos(album['id']).first.first['source'],
        "album_id" => album['id'],
        "album_name" => album['name']
      }
    end
  end

  def about
    object.content['about']
  end

  def posts
    object.content['feed']['data'].map do |feed|
      {
        "message" => feed['message'],
        "image" => feed['full_picture']
      }
    end
  end

  def events
    object.content['events']['data'].map do |event|
      {
        "name" => event['name'],
        "location" => event['place'],
        "details" => event['description']
      }
    end
  end

  def description
    object.content['description']
  end

  def photos(album_id)
    albums = object.content['albums']['data'].select do |album|
      album["id"] == album_id
    end
    albums.first['photos']['data'].map do |photo|
      photo["images"]
    end
  end
end
