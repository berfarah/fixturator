module Fixturator
  class Configuration
    def initialize
      file = config_file
      hash = file ? YAML.load(file) : default_hash
      hash.each do |method_name, value|
        public_send("#{method_name}=", value)
      end
    end

    attr_accessor :excluded_models,
                  :included_models,
                  :excluded_attributes,
                  :model_level_excluded_attributes

    private

    def default_hash
      {
        "excluded_models" => [],
        "included_models" => [],
        "excluded_attributes" => [],
        "model_level_excluded_attributes" => Hash.new { |h, k| h[k] = [] },
      }
    end

    def config_file
      return nil unless File.exist?(config_path)
      File.read(config_path)
    end

    def config_path
      Rails.root.join("config", "fixturator.yml")
    end
  end
end
