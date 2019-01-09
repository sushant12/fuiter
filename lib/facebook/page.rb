# frozen_string_literal: true

module Facebook
  class Page
    def initialize(access_token:)
      @graph = Koala::Facebook::API.new(access_token)
    end

    def list
      @graph.get_connections('me', '?fields=accounts{category,cover,name,access_token}')
    end

    def get_info
      @graph.get_connections('me', '?fields=about,bio,company_overview,contact_address,current_location,description,description_html,founded,general_info,access_token,location,mission,name,albums{description,name,count,photo_count,photos{images}},posts{created_time,description,full_picture,id,link,message,name,source,type,attachments{description,title,url}},events{cover,description,end_time,event_times,name,place,start_time,ticket_uri}')
    end
  end
end
