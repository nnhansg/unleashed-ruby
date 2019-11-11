require_relative 'unleashed/client'
require_relative 'unleashed/default'
require_relative 'unleashed/error'
require_relative 'unleashed/version'

module Unleashed
  class << self
    include Unleashed::Configurable
  end
end

Unleashed.setup
