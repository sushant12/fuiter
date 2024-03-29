# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
# require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
# require 'action_cable/engine'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'sprockets/railtie'

# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fuitter
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    load_path_strategy = Rails.env.production? ? :eager_load_paths : :autoload_paths
    config.public_send(load_path_strategy) << Rails.root.join('lib')
    config.assets.precompile += %w[template.js template.css]
    # Don't generate system test files.
    config.generators.system_tests = nil
    config.generators do |g|
      g.template_engine :slim
      g.test_framework  false
      g.assets false
      g.helper false
      g.stylesheets false
    end
    config.active_job.queue_adapter = :sidekiq

    config.active_record.dump_schema_after_migration = true
    config.active_record.schema_format = :sql

    config.filter_parameters << :password

    if Rails.env.production?
      Raven.configure do |config|
        config.dsn = ENV['SENTRY_DSN']
      end
    end

    config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Flash
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    # App specific configuration
    config.x = config_for(:app).with_indifferent_access
  end

  def self.config
    @config ||= Rails.configuration.x
  end

  def self.reserved_subdomains
    @reserved_subdomains ||= %w[www app apps blog blogs help support].freeze
  end

  def self.credentials
    @credentials ||= Rails.application.credentials[Rails.env.to_sym]
  end
end
