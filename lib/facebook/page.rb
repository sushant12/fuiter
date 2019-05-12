# frozen_string_literal: true

module Facebook
  class Page
    def initialize(access_token)
      @graph = Koala::Facebook::API.new(access_token)
    end

    def list
      @graph.get_connections('me', '?fields=accounts{category,name,access_token,picture.type(large){url}}')
    end

    def get_info
      @graph.get_connections('me', '?fields=id,about,phone,emails,bio,company_overview,contact_address,current_location,description,description_html,founded,general_info,access_token,location,mission,name,albums.limit(99){description,name,count,photo_count,photos.limit(99){images}},posts.limit(99){created_time,description,full_picture,id,link,message,name,source,type,attachments{description,title,url}},events{cover,description,end_time,event_times,name,place,start_time,ticket_uri}')
    end
  end
end
