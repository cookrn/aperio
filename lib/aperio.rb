# Get access to mattr_* methods
require 'active_support/dependencies'

module Aperio

  # Autoloads
  autoload :Exceptions , 'aperio/exceptions'
  autoload :Helpers, 'aperio/helpers'

  # Set our route namespace
  mattr_accessor :route_namespace
  @@route_namespace = '/oauth'

  # Define the model name in the host app to authenticate against
  mattr_accessor :authentication_model
  @@authentication_model = "User"

  # Define the authentication identifier
  mattr_accessor :authentication_identifier
  @@authentication_identifier = "email"

  # Define the authentication secret
  mattr_accessor :authentication_secret
  @@authentication_secret = "password"

  # Config yields self
  def self.setup
    yield self
  end

  # Requires
  require 'aperio/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3

end

