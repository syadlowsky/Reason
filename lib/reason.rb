require "reason/version"
require "rubygems"
require "rspec/core/formatters/documentation_formatter"
# require "rson/because"
module Reason
  module Explanations
    def because(reason)
      example_group = self.examples.last
      Reason::Explanations.add(example_group, reason)
    end
    def self.included(mod)
      mod.extend self
    end
    def self.explanations
      @explanations ||= Hash.new
    end
    def self.add(example, reason)
      explanations[example] ||= Array.new
      explanations[example] << reason
    end
    def self.print_for(example, options={})
      depth = options[:depth] || 0
      indentation = "  " * depth
      if explanations[example]
        "#{indentation}-> because #{explanations[example].join("\n#{indentation}->")}"
      else
        ""
      end
    end
  end
end

module RSpec
  module Core
    module Formatters
      class DocumentationFormatter < BaseTextFormatter
        alias_method :old_passed, :example_passed
        def example_passed(example)
          old_passed(example)
          output.puts yellow(Reason::Explanations.print_for(example, :depth => @group_level))
        end
        alias_method :old_pending, :example_pending
        def example_pending(example)
          old_pending(example)
          output.puts yellow(Reason::Explanations.print_for(example, :depth => @group_level))
        end
        alias_method :old_failed, :example_failed
        def example_failed(example)
          old_failed(example)
          output.puts yellow(Reason::Explanations.print_for(example, :depth => @group_level))
        end
      end
    end
  end
end
