require 'aperio'
require 'rails'

module Aperio

  # Setup the rails engine
  class Engine < Rails::Engine

    #set our mount point
    config.mount_at = Aperio.mount_point

    #set an initializer to check our mount point
    initializer "aperio.check_mount_at_config" do |app|
      config.mount_at << Aperio.mount_point unless config.mount_at.last == Aperio.mount_point
    end

  end

end

