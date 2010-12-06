require 'active_support/dependencies'

module Aperio

  #set our mount point
  mattr_accessor :mount_point
  @@mount_point = '/oauth'

  #config yields self
  def self.setup
    yield self
  end

end

require 'aperio/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3

