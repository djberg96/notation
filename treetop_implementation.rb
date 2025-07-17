#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'lib/notation'

puts "🌳 Treetop Parser Implementation for Unicode Infix Notation 🌳"
puts "=" * 70

# Load and compile the grammar
Treetop.load_from_string(File.read('notation_grammar.treetop'))

class NotationEvaluator
  def initialize
    @parser = NotationGrammarParser.new
  end

  def eval(expression)
    puts "🔍 Parsing: #{expression}"

    # Parse the expression
    tree = @parser.parse(expression.strip)

    if tree.nil?
      puts "❌ Parse failed at position #{@parser.index}"
      puts "   Reason: #{@parser.failure_reason}"
      return nil
    end

    puts "✅ Parse tree: #{tree.class}"

    # Evaluate the parsed tree
    result = tree.eval_node
    puts "📊 Result: #{result}"
    result
  rescue => e
    puts "❌ Error: #{e.message}"
    nil
  end
end

# Add convenience method to Kernel
module Kernel
  def notation_eval(expression)
    evaluator = NotationEvaluator.new
    evaluator.eval(expression)
  end
end

puts "\n🧪 TESTING TREETOP PARSER:"
puts "=" * 35

test_cases = [
  "10 ≥ 5",
  "5 ≤ 10",
  "5 ≠ 3",
  "3.14159 ≈ 3.14160",
  "√ 49",
  "！ 5",
  "｜ -42",
  "∛ 27",
  "∜ 16",
  # Standard operators for comparison
  "10 >= 5",
  "5 <= 10",
  "5 != 3",
  "10 > 5",
  "5 < 10",
  "5 == 5",
  # Parentheses
  "(10 ≥ 5)",
  "(√ 49)"
]

test_cases.each do |test|
  puts "\n📝 Testing: #{test}"
  result = notation_eval(test)
  puts "   ✓ Result: #{result}" if result
end

puts "\n🎯 ADVANCED FEATURES:"
puts "=" * 25

puts "\n🔧 Complex expressions with parentheses:"
notation_eval("(10 ≥ 5)")
notation_eval("(√ 49)")

puts "\n🎊 TREETOP ADVANTAGES:"
puts "=" * 25
puts "✅ More powerful than Parslet"
puts "✅ Better error reporting"
puts "✅ Can handle complex nested expressions"
puts "✅ Supports parentheses and precedence"
puts "✅ Extensible grammar"
puts "✅ Compiles to pure Ruby code"

puts "\n📋 INTEGRATION GUIDE:"
puts "=" * 20
puts <<~INTEGRATION
To integrate into your notation gem:

1. Add treetop dependency to gemspec:
   spec.add_dependency 'treetop', '~> 1.6'

2. Include the grammar file in your gem

3. Add the evaluator class to lib/notation.rb

4. Compile grammar at load time:
   Treetop.load_from_string(grammar_content)

5. Export notation_eval method

This gives much more sophisticated parsing than Parslet!
INTEGRATION

puts "\n" + "=" * 70
puts "✨ Treetop provides industrial-strength parsing! ✨"
