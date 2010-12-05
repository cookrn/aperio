require 'aperio/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3

module Aperio
  #config yields self
  def self.setup
    yield self
  end
end
