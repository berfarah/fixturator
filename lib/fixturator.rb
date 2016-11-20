require "fixturator/railtie"
require "fixturator/locator"
require "fixturator/generator"

module Fixturator
  def self.generate!(except: [], only: [], excluded_attributes: [])
    models = Locator.new(except: except, only: only).call

    models.each do |model|
      puts "Generating fixtures for #{model}..."
      call(model, excluded_attributes: excluded_attributes)
    end
  end

  def self.call(*args)
    Generator.new(*args).call
  end
end
