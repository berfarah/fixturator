require "test_helper"
require "rake"
require "minitest/spec"
require "fileutils"

class FixturatorTest < ActiveSupport::TestCase
  extend Minitest::Spec::DSL

  describe ".generate!" do
    it "succeeds" do
      hide_stdout do
        Fixturator.generate!
      end
    end
  end

  describe "rake task" do
    before do
      Dummy::Application.load_tasks
      FileUtils.mkdir_p(Rails.root.join("test", "fixtures"))
    end

    it "succeeds" do
      hide_stdout do
        assert_nothing_raised do
          Rake::Task['db:fixtures:generate'].invoke
        end
      end
    end
  end

  def hide_stdout
    stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout = stdout
  end
end
