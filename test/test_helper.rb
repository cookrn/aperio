# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

