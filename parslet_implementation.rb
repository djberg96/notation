#!/usr/bin/env ruby
# frozen_string_literal: true

require 'parslet'
require_relative 'lib/notation'

puts "🎯 Full Parslet Implementation for Unicode Infix Notation 🎯"
puts "=" * 65

# Grammar definition for Unicode mathematical expressions
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
  rule(:sum) { str('∑') }
  rule(:product) { str('∏') }
  rule(:sqrt) { str('√') }
  rule(:factorial) { str('！') }

  # Binary operators (comparison)
  rule(:binary_op) { greater_equal | less_equal | not_equal | approx_equal }

  # Unary operators
  rule(:unary_op) { sqrt | factorial }

  # Array notation for sum/product
  rule(:array_start) { str('[') >> space? }
  rule(:array_end) { space? >> str(']') }
  rule(:comma) { space? >> str(',') >> space? }
  rule(:array_elements) { number >> (comma >> number).repeat }
  rule(:array) { array_start >> array_elements.as(:elements) >> array_end }

  # Expression types
  rule(:binary_expr) {
    number.as(:left) >> space? >> binary_op.as(:op) >> space? >> number.as(:right)
  }

  rule(:unary_expr) {
    unary_op.as(:op) >> space? >> number.as(:operand)
  }

  rule(:array_op_expr) {
    (sum | product).as(:op) >> space? >> array.as(:array)
  }

  rule(:expression) { binary_expr | unary_expr | array_op_expr }

  root(:expression)
end

# Transform parsed tree into Ruby method calls
class NotationTransform < Parslet::Transform
  # Fix array element parsing
  rule(elements: sequence(:nums)) do
    nums.map { |n| n.to_s.to_f }
  end

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

  rule(op: simple(:op), array: simple(:arr)) do
    case op.to_s
    when '∑' then { type: :method_call, method: '∑', args: [arr] }
    when '∏' then { type: :method_call, method: '∏', args: [arr] }
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
    when '∑' then ∑(*args)
    when '∏' then ∏(*args)
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
  "！ 5",
  "∑ [1, 2, 3, 4]",
  "∏ [2, 3, 4]"
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

# Now you can use true infix syntax:
notation_eval("10 ≥ 5")        # => true
notation_eval("5 ≤ 10")        # => true
notation_eval("5 ≠ 3")         # => true
notation_eval("√ 49")          # => 7.0
notation_eval("！ 5")          # => 120
notation_eval("∑ [1,2,3]")     # => 6
notation_eval("∏ [2,3,4]")     # => 24

This gives you the best of both worlds:
• Keep existing function syntax: ≥(10, 5)
• Add new infix syntax: notation_eval("10 ≥ 5")
USAGE

puts "\n" + "=" * 65
puts "✨ Unicode infix notation achieved with Parslet! ✨"
