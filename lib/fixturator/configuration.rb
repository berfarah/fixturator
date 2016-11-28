require "yaml"
require "fixturator/model"

module Fixturator
  class Configuration
    class << self
      def load
        hash = YAML.safe_load(config_file)
        hash ? new(**hash.symbolize_keys!) : new
      end

      private

      def config_file
        return "" unless File.exist?(config_path)
        File.read(config_path)
      end

      def config_path
        Rails.root.join("config", "fixturator.yml")
      end
    end

    def initialize(models: [], exclude_timestamps: false)
      @models = models.map(&Model.method(:new)).compact
      exclude_timestamps_from(@models) if exclude_timestamps
    end

    attr_reader :models

    private

    def exclude_timestamps_from(models)
      models.each { |model| model.excluded_attributes.concat(timestamps) }
    end

    def timestamps
      %w(created_at updated_at)
    end
  end
end
