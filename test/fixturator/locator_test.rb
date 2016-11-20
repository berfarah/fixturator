require "test_helper"
require "minitest/spec"

class Fixturator::LocatorTest < ActiveSupport::TestCase
  extend Minitest::Spec::DSL

  let(:models) { [::User, ::Post] }
  subject { Fixturator::Locator.new(except: except, only: only) }
  let(:except) { [] }
  let(:only) { [] }

  describe "when no parameters are passed" do
    it "finds all the models" do
      result = subject.call

      assert result.include?(::User), "Did not contain the User model"
      assert result.include?(::Post), "Did not contain the Post model"
    end
  end

  describe "when we are black-listing models" do
    let(:except) { %w(User) }

    it "it does not find those models" do
      assert_equal [Post], subject.call
    end
  end

  describe "when we are white-listing models" do
    let(:only) { %w(User) }

    it "it finds only those models" do
      assert_equal [User], subject.call
    end
  end
end
