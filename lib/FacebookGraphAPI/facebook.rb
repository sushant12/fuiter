module Facebook 
  class Page
    def initialize(access_token)
      @graph = Koala::Facebook::API.new(access_token)
    end

    # this method lists all facebook page of loggedIn user
    def list_user_fb_page
      @graph.get_connections("me", "?fields=accounts{category,cover,name,access_token}")
    end

    # this methods provides the details of selected facebook page
    def selected_fb_page_info
      @graph.get_connections("me", "?fields=about,bio,company_overview,contact_address,cover,current_location,description,description_html,founded,general_info,access_token,location,mission,name,albums{description,name,count,photo_count,photos{images}},feed{description,full_picture,message,picture,attachments{description,media,url},type},events{cover,description,end_time,event_times,name,place,start_time,ticket_uri}")
    end
  end
end
