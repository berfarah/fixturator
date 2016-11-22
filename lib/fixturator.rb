require "fixturator/railtie"
require "fixturator/configuration"
require "fixturator/locator"
require "fixturator/generator"

module Fixturator
  class << self
    def generate!
      config = Configuration.new
      yield config if block_given?

      locate(config).each do |model|
        puts "Generating fixtures for #{model}..."

        call(
          model,
          excluded_attributes: exclusions_for(model: model, config: config),
        )
      end
    end

    def call(*args)
      Generator.new(*args).call
    end

    def to_proc
      method(:call)
    end

    private

    def locate(config)
      Locator.new(
        except: config.excluded_models,
        only: config.included_models,
      ).call
    end

    def exclusions_for(model:, config:)
      exclusions = config.model_level_excluded_attributes[model.to_s]
      exclusions + config.excluded_attributes
    end
  end
end
