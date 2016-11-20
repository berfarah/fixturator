require 'fixturator'

namespace :db do
  namespace :fixtures do

    desc <<-DESC
    Generate fixtures based off of active_record models.
    Options:
      SKIP:          comma separated list of tables to be skipped
      ONLY:          comma separated list of tables to be fixturized
      EXCLUDE_ATTRS: comma separated list of excluded attributes
    DESC

    def arrayify(env_str)
      env_str ||= ""
      env_str.split(/\s*,\s*/)
    end

    task generate: :environment do
      except = arrayify(ENV["SKIP"])
      only = arrayify(ENV["ONLY"])
      excluded_attributes = arrayify(ENV["EXCLUDE_ATTRS"])

      Fixturator.generate!(
        except: except,
        only: only,
        excluded_attributes: excluded_attributes,
      )
    end
  end
end
