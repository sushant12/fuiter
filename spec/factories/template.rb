# frozen_string_literal: true

FactoryBot.define do
  factory :template do
    name { "test_template" }
    properties { {"slider": [
      {"source": "https://via.placeholder.com/728x90.png?text=Visit+WhoIsHostingThis"}, 
      {"source": "https://via.placeholder.com/728x90.png"}
    ]}}
  end
end