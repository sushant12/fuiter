module Facebook
  class Page
    def initialize(token)
      @graph = Koala::Facebook::API.new(token)
    end

    def list
      @graph.get_connections("me", "?fields=accounts{category,cover,name,access_token}")
    end

    def get_info
      @graph.get_connections("me", "?fields=about,bio,company_overview,contact_address,cover,current_location,description,description_html,founded,general_info,access_token,location,mission,name,albums{description,name,count,photo_count,photos{images}},feed{description,full_picture,message,picture,attachments{description,media,url},type},events{cover,description,end_time,event_times,name,place,start_time,ticket_uri}")
    end
  end
end