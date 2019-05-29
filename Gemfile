# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'stripe'

group :development, :test do
  gem 'sass-rails'
  gem 'uglifier'
  gem 'coffee-rails'
  gem 'scout_apm'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry'

  # better error page for Rack apps
  gem 'better_errors'

  # used to retrieve the binding of a method's caller(used in debugging situations)
  gem 'binding_of_caller'

  # To kill N+1 queries and unused eager loading
  gem 'bullet'

  # Manage Procfile-based applications
  gem 'foreman'

  # Use to preview email in the default browser instead of sending it
  gem 'awesome_print'
  gem 'letter_opener'
  gem 'rspec-rails', '~> 3.8'

  # Simplecov is a code coverage analysis tool for Ruby
  gem 'simplecov'

  gem 'factory_bot_rails'

  gem 'rubocop-rspec'

  # clears database after each tests
  gem 'database_cleaner'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'web-console', '>= 3.3.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Used to generate a diagram based on your application's Active Record models
  gem 'rails-erd'
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.3", require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-rbenv', '~> 2.1',require: false
  gem 'capistrano-bundler', '~> 1.5', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# facebook library for graph api
gem 'koala'

# Used for handling user session
gem 'devise'
gem 'omniauth-facebook'

# Used for maintaining environment variables
gem 'dotenv-rails'

# Background processing for ruby
gem 'sidekiq'

# Slim template generator for rails
gem 'slim-rails'

gem 'draper'

gem 'sentry-raven'

# Organise ActiveRecord model into a tree structure
gem 'ancestry'

# used for file/image uploads
gem 'carrierwave'

# ActiveAdmin
gem 'activeadmin'
gem 'fog-aws'
gem 'geocoder'