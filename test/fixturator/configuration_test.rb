require "test_helper"
require "minitest/spec"

class Fixturator::ConfigurationTest < ActiveSupport::TestCase
  extend Minitest::Spec::DSL

  subject { Fixturator::Configuration.new }

  let(:excluded_models) { %w(Secret DelayedJob) }
  let(:included_models) { %w(User) }
  let(:excluded_attributes) { %w(secret_attribute ssn) }
  let(:model_level_excluded_attributes) { { "User" => %w(middle_name drivers_license) } }

  it "writes the attributes" do
    assert_equal excluded_models, subject.excluded_models
    assert_equal included_models, subject.included_models
    assert_equal excluded_attributes, subject.excluded_attributes
    assert_equal model_level_excluded_attributes, subject.model_level_excluded_attributes
  end
end
