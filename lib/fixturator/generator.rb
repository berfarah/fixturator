require "yaml"

module Fixturator
  class Generator
    def initialize(model, excluded_attributes: [])
      @model = model
      @excluded_attributes = excluded_attributes
    end

    def call
      with_fixture_file do |file|
        model.find_each.with_index do |record, index|
          file.puts(fixturize(record, index + 1))
        end
      end
    end

    private

    attr_reader :model, :excluded_attributes

    def with_fixture_file(&block)
      File.open(fixture_path, "w", &block)
    end

    def fixturize(record, index)
      to_yaml(
        "#{model_lower_name}_#{index}" => attributes_for(record)
      )
    end

    def to_yaml(hash)
      remove_yaml_header(hash.to_yaml) + "\n"
    end

    def remove_yaml_header(yaml)
      yaml.sub(/\A---\n/, "")
    end

    def attributes_for(record)
      record.
        attributes.
        compact.
        tap(&method(:replace_times)).
        except(*excluded_attributes)
    end

    def replace_times(attributes)
      attributes["created_at"] = static_time if attributes["created_at"]
      attributes["updated_at"] = static_time if attributes["updated_at"]
    end

    def static_time
      Time.parse("2016-10-10").utc
    end

    def fixture_path
      if Rails::VERSION::MAJOR > 5
        ActiveSupport::TestCase.fixture_path
      else
        Rails.root.join("test", "fixtures", model_lower_name.pluralize + ".yml")
      end
    end

    def model_lower_name
      model.name.underscore.gsub("/", "_")
    end
  end
end
