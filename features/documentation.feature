Feature: Documentation formatter support
  As a behaviour driven developer
  When I use `because` to enforce contracts
  I need to be able to see it in my documentation output

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

  Scenario: Displaying reason for an "it" block
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
    When I run `rspec spec --format documentation`
    Then it should pass with:
    """
    String
      should support concatenation
      -> because NaturalLanguageProcessor uses this in its .greeting_generator method
    """

  Scenario: Display normal output if no because
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
    end
    """
    When I run `rspec spec --format documentation`
    Then it should pass with:
    """
    String
      should support concatenation
    """

