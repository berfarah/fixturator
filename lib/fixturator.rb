require "fixturator/railtie"
require "fixturator/configuration"
require "fixturator/generator"

module Fixturator
  class << self
    def generate!
      config = Configuration.load
      yield config if block_given?

      config.models.each do |model|
        puts "Generating fixtures for #{model.name}..."
        model.to_fixture
      end
    end

    def call(*args)
      Generator.new(*args).call
    end

    def to_proc
      method(:call)
    end
  end
end
