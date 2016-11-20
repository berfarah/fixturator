require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "fixturator"

module Dummy
  class Application < Rails::Application
  end
end

Rails.application.configure do
  config.eager_load = false
end
