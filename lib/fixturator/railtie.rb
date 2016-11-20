module Fixturator
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/fixtures_generate.rake"
    end
  end
end
