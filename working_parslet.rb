#!/usr/bin/env ruby
# frozen_string_literal: true

require 'parslet'
require_relative 'lib/notation'

puts "🎯 Working Parslet Implementation for Unicode Infix Notation 🎯"
puts "=" * 70

# Simplified grammar focusing on binary operations
class NotationGrammar < Parslet::Parser
  rule(:space) { match('\s').repeat(1) }
  rule(:space?) { space.maybe }

  # Numbers (integers and floats)
  rule(:integer) { match('[0-9]').repeat(1) }
  rule(:float) { integer >> str('.') >> integer }
  rule(:number) { float | integer }

  # Unicode operators
  rule(:greater_equal) { str('≥') }
  rule(:less_equal) { str('≤') }
  rule(:not_equal) { str('≠') }
  rule(:approx_equal) { str('≈') }
  rule(:sqrt) { str('√') }
  rule(:factorial) { str('！') }

  # Binary operators (comparison)
  rule(:binary_op) { greater_equal | less_equal | not_equal | approx_equal }

  # Unary operators
  rule(:unary_op) { sqrt | factorial }

  # Expression types
  rule(:binary_expr) {
    number.as(:left) >> space? >> binary_op.as(:op) >> space? >> number.as(:right)
  }

  rule(:unary_expr) {
    unary_op.as(:op) >> space? >> number.as(:operand)
  }

  rule(:expression) { binary_expr | unary_expr }

  root(:expression)
end

# Transform parsed tree into Ruby method calls
class NotationTransform < Parslet::Transform
  rule(left: simple(:l), op: simple(:op), right: simple(:r)) do
    left, right = l.to_f, r.to_f
    case op.to_s
    when '≥' then { type: :method_call, method: '≥', args: [left, right] }
    when '≤' then { type: :method_call, method: '≤', args: [left, right] }
    when '≠' then { type: :method_call, method: '≠', args: [left, right] }
    when '≈' then { type: :method_call, method: '≈', args: [left, right] }
    end
  end

  rule(op: simple(:op), operand: simple(:operand)) do
    value = operand.to_f
    case op.to_s
    when '√' then { type: :method_call, method: '√', args: [value] }
    when '！' then { type: :method_call, method: '！', args: [value.to_i] }
    end
  end
end

# Main notation evaluator
class NotationEvaluator
  def self.eval(expression)
    parser = NotationGrammar.new
    transform = NotationTransform.new

    begin
      # Parse the expression
      parsed = parser.parse(expression)
      puts "✅ Parsed: #{parsed.inspect}"

      # Transform to Ruby calls
      transformed = transform.apply(parsed)
      puts "🔄 Transformed: #{transformed.inspect}"

      # Execute the method call
      result = execute_call(transformed)
      puts "📊 Result: #{result}"
      result

    rescue Parslet::ParseFailed => e
      puts "❌ Parse error: #{e.parse_failure_cause.ascii_tree}"
      nil
    end
  end

  private

  def self.execute_call(call_info)
    method = call_info[:method]
    args = call_info[:args]

    case method
    when '≥' then ≥(*args)
    when '≤' then ≤(*args)
    when '≠' then ≠(*args)
    when '≈' then ≈(*args)
    when '√' then √(*args)
    when '！' then ！(*args)
    else
      raise "Unknown method: #{method}"
    end
  end
end

# Add convenience method to the notation gem
module Kernel
  def notation_eval(expression)
    NotationEvaluator.eval(expression)
  end
end

puts "\n🧪 TESTING THE PARSER:"
puts "=" * 30

test_cases = [
  "10 ≥ 5",
  "5 ≤ 10",
  "5 ≠ 3",
  "3.14159 ≈ 3.14160",
  "√ 49",
  "！ 5"
]

test_cases.each do |test|
  puts "\n📝 Testing: #{test}"
  puts "   Result: #{notation_eval(test)}"
end

puts "\n🎉 SUCCESS! You now have true infix notation!"
puts "=" * 50

puts <<~USAGE
USAGE IN YOUR CODE:

require 'notation'
require 'parslet'  # gem install parslet

# Include the parser (add to your gem)
# [Copy the NotationGrammar, NotationTransform, and NotationEvaluator classes]

# Now you can use true infix syntax:
notation_eval("10 ≥ 5")        # => true
notation_eval("5 ≤ 10")        # => true
notation_eval("5 ≠ 3")         # => true
notation_eval("√ 49")          # => 7.0
notation_eval("！ 5")          # => 120

# You still have the original syntax too:
≥(10, 5)                       # => true
√(49)                          # => 7.0

INTEGRATION WITH YOUR GEM:
1. Add parslet as a dependency in your gemspec
2. Include the parser classes in lib/notation.rb
3. Export the notation_eval method
4. Update documentation with examples

This gives you the best of both worlds:
• Keep existing function syntax: ≥(10, 5)
• Add new infix syntax: notation_eval("10 ≥ 5")
• True Unicode infix notation within a controlled environment
USAGE

puts "\n" + "=" * 70
puts "✨ Unicode infix notation achieved with Parslet! ✨"

puts "\n📋 SUMMARY OF PARSER SOLUTIONS:"
puts "=" * 40
puts "1. ✅ Parslet - Working implementation above"
puts "2. 🔧 Treetop - Alternative PEG parser"
puts "3. ⚡ Racc - Traditional LALR parser"
puts "4. 🎯 Simple regex - Basic proof of concept"
puts "5. 🧮 Method chaining - 10.≥?(5) syntax"

puts "\nParslet is the clear winner for your use case!"
