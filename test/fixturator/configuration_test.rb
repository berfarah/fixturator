require "test_helper"
require "minitest/spec"

class Fixturator::ConfigurationTest < ActiveSupport::TestCase
  extend Minitest::Spec::DSL

  subject { Fixturator::Configuration.load }

  class Driver; end

  let(:models) { %w(User) }
  let(:excluded_attributes) { %w(secret_attribute ssn) }
  let(:timestamps) { %w(created_at updated_at) }

  describe "#models" do
    it "includes valid class names" do
      model_names = subject.models.map(&:name)
      assert model_names.include?(::User), "Models should include valid models"
      refute model_names.include?(Driver), "Models should exclude invalid models"
    end

    it "includes nested attributes" do
      user = subject.models.first
      assert_equal excluded_attributes, user.excluded_attributes
    end
  end

  describe "ignore_timestamps" do
    let(:models) { [{ "name" => "User", "exclude" => excluded_attributes.dup }] }
    subject { Fixturator::Configuration.new(models: models, exclude_timestamps: true) }

    it "adds timestamps to blacklisted attributes" do
      user = subject.models.first
      refute_equal excluded_attributes, user.excluded_attributes
      assert_equal excluded_attributes + timestamps, user.excluded_attributes
    end
  end
end
