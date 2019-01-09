# frozen_string_literal: true

# Koala initializer file
Koala.configure do |config|
  config.app_id = ENV['APP_ID']
  config.app_secret = ENV['APP_SECRET']
end
