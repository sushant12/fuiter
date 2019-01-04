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

group :development, :test do
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
  gem 'letter_opener'
  gem 'awesome_print'
  gem 'rspec-rails', '~> 3.8'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Used to generate a diagram based on your application's Active Record models
  gem 'rails-erd'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

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
