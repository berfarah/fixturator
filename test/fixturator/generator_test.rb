require "test_helper"
require "minitest/spec"

class Fixturator::GeneratorTest < ActiveSupport::TestCase
  extend Minitest::Spec::DSL

  subject { Fixturator::Generator.new(model) }
  let(:model) { ::User }
  let(:tempfile) { @tempfile.path }

  before do
    @tempfile = Tempfile.new("fixtures.yml")
    subject.stubs(fixture_path: @tempfile.path)
    User.destroy_all
    3.times do |i|
      User.create!(name: "Foo#{i + 1}")
    end
  end

  after do
    @tempfile.unlink
  end

  let(:fixture_hash) { YAML.load_file(tempfile) }
  let(:fixture_name) { "user_3" }

  it "writes the attributes" do
    subject.call
    assert_equal fixture_name, fixture_hash.keys.last
    assert_equal "Foo3", fixture_hash[fixture_name]["name"]
  end
end
