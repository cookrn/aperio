# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
ENV["RAILS_ROOT"] = File.expand_path("../dummy",  __FILE__)

# Load the rails dummy app
require "dummy/config/environment"
require "rails/test_help"

# Configure the dummy rails app
ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "test.com"
Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
require 'capybara/rails'
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css

# Run any available migration
ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

