require "fixturator/generator"

module Fixturator
  class Model
    class << self
      def new(hash)
        name = to_model(hash["name"]) or return nil

        hash["name"] = name
        super(hash)
      end

      private

      def to_model(name)
        name = name.safe_constantize or return nil
        name.ancestors.include?(ActiveRecord::Base) ? name : nil
      end
    end

    def initialize(hash)
      @name = hash.fetch("name")
      @excluded_attributes = hash.fetch("exclude", [])
    end

    attr_reader :name, :excluded_attributes

    def to_fixture
      Generator.new(name, excluded_attributes: excluded_attributes).call
    end
  end
end
