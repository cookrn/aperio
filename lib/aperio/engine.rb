require 'aperio'
require 'rails'

module Aperio
  class Engine < Rails::Engine

    #set our mount point
    config.mount_at = '/'

    #set an initializer to check our mount point
    initializer "aperio.check_mount_at_config" do |app|
      config.mount_at << '/' unless config.mount_at.last == '/'
    end

  end
end

