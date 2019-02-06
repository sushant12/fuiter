# frozen_string_literal: true

FactoryBot.define do
  factory :fb_page_template do
    pages do
      [
        {"uri": "about", 
          "title": "About", 
          "nested": [{
              "uri": "events", 
              "title": "Events", 
              "position": 3
            }], 
          "position": 2}, 
        {"uri": "contact", 
         "title": "Contact",
         "nested": [],
         "position": 5},
        {"uri": "home",
         "title": "Home",
         "nested": [],
         "position": 1},
        {"uri": "news",
         "title": "News",
         "nested": [],
         "position": 6},
        {"uri": "gallery",
         "title": "Gallery",
         "nested": [],
         "position": 4}]
    end
  end
end
