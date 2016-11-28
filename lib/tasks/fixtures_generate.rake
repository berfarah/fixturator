require 'fixturator'

namespace :db do
  namespace :fixtures do

    desc "Generate fixtures based off of active_record models."
    task generate: :environment do
      Fixturator.generate!
    end
  end
end
