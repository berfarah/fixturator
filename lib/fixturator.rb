require "fixturator/generator"

module Fixturator
  def self.call(*args)
    Generator(*args).call
  end
end
