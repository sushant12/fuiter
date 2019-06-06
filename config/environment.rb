# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => Rails.application.credentials.smtp_username,
  :password => Rails.application.credentials.smtp_password,
  :domain => Rails.application.credentials.smtp_domain,
  :address => 'smtp.sendgrid.net',
  :port => Rails.application.credentials.smtp_port,
  :authentication => :plain,
  :enable_starttls_auto => true
}
