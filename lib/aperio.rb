require 'active_support/dependencies'

module Aperio

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

  #config yields self
  def self.setup
    yield self
  end

end

require 'aperio/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3

