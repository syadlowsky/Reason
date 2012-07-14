Feature: `before` clause for describing tests
  As a behaviour driven developer
  In order to keep track of why specifications are required
  I want a way to document the reason for a test.

  Background:
    Given a file named "spec/spec_helper.rb" with:
    """
    require "rubygems"
    require "bundler/setup"
    require "reason"
    RSpec.configure do |config|
      config.include Reason::Explanations
    end
    """

  Scenario: Simple test with a reason
    Given a file named "spec/simple_spec.rb" with:
    """
    require "spec_helper"

    describe String do
      subject { "a simple string" }

      it { should respond_to(:to_s) }
      because "sometimes symbols and strings both get to_s called on them"
    end
    """
    When I run `rspec spec`
    Then the example should pass

  Scenario: More complex matchers with a reason
    Given a file named "spec/simple_spec.rb" with:
    """
    require "spec_helper"

    describe String do
      subject { "a simple string" }
      let(:welcome_message) { "Hello" }
      let(:name) { "Steve Yadlowsky" }

      it "should support concatenation" do
        greeting = welcome_message + ", " + name
        greeting.should == "Hello, Steve Yadlowsky"
      end
      because "NaturalLanguageProcessor uses this in its .greeting_generator method"
    end
    """
    When I run `rspec spec`
    Then the example should pass
