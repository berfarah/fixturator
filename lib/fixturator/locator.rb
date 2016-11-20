module Fixturator
  class Locator
    def initialize(except: [], only: [])
      Rails.application.eager_load!

      @except = map_to_models(except)
      @only = map_to_models(only)
    end

    def call
      return models & only unless only.empty?
      models.reject!(&:abstract_class) if Rails::VERSION::MAJOR >= 5
      models
    end

    private

    def models
      @models ||= ActiveRecord::Base.descendants - exceptions
    end

    attr_reader :except, :only

    def map_to_models(array)
      array.map(&:safe_constantize).compact
    end

    def exceptions
      [schema_migration] + except
    end

    def schema_migration
      ActiveRecord::SchemaMigration
    end
  end
end
