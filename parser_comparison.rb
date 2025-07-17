#!/usr/bin/env ruby
# frozen_string_literal: true

require 'parser/current'
require_relative 'lib/notation'

puts "🎯 Ruby Parser Gem - AST Transformation Approach 🎯"
puts "=" * 60

# Custom processor to transform Ruby AST
class NotationProcessor < Parser::AST::Processor
  def on_send(node)
    receiver, method_name, *args = *node

    # Transform method calls to our Unicode operators
    case method_name
    when :≥, :gte then process_binary_op(args, :≥)
    when :≤, :lte then process_binary_op(args, :≤)
    when :≠, :neq then process_binary_op(args, :≠)
    when :≈, :approx then process_binary_op(args, :≈)
    when :√, :sqrt then process_unary_op(args, :√)
    when :∛, :cbrt then process_unary_op(args, :∛)
    when :∜, :frrt then process_unary_op(args, :∜)
    when :！, :fact then process_unary_op(args, :！)
    else
      super
    end
  end

  private

  def process_binary_op(args, op)
    if args.length == 2
      left = extract_value(args[0])
      right = extract_value(args[1])

      case op
      when :≥ then ≥(left, right)
      when :≤ then ≤(left, right)
      when :≠ then ≠(left, right)
      when :≈ then ≈(left, right)
      end
    end
  end

  def process_unary_op(args, op)
    if args.length == 1
      value = extract_value(args[0])

      case op
      when :√ then √(value)
      when :∛ then ∛(value)
      when :∜ then ∜(value)
      when :！ then ！(value.to_i)
      end
    end
  end

  def extract_value(node)
    case node.type
    when :int then node.children[0]
    when :float then node.children[0]
    else
      raise "Unsupported node type: #{node.type}"
    end
  end
end

# DSL-style notation evaluator
class NotationDSL
  def self.eval(&block)
    # Create a custom binding with our Unicode methods
    binding = create_notation_binding
    binding.eval(&block)
  end

  private

  def self.create_notation_binding
    # This approach creates a clean namespace with just our operators
    clean_binding = Object.new.instance_eval { binding }

    # Add our Unicode operators to the binding
    clean_binding.define_singleton_method(:≥) { |a, b| Kernel.≥(a, b) }
    clean_binding.define_singleton_method(:≤) { |a, b| Kernel.≤(a, b) }
    clean_binding.define_singleton_method(:≠) { |a, b| Kernel.≠(a, b) }
    clean_binding.define_singleton_method(:≈) { |a, b| Kernel.≈(a, b) }
    clean_binding.define_singleton_method(:√) { |x| Kernel.√(x) }
    clean_binding.define_singleton_method(:∛) { |x| Kernel.∛(x) }
    clean_binding.define_singleton_method(:∜) { |x| Kernel.∜(x) }
    clean_binding.define_singleton_method(:！) { |x| Kernel.！(x) }

    clean_binding
  end
end

# Alternative: String-based transformation approach
class StringTransformer
  TRANSFORMATIONS = {
    /(\d+(?:\.\d+)?)\s*≥\s*(\d+(?:\.\d+)?)/ => 'Kernel.≥(\1, \2)',
    /(\d+(?:\.\d+)?)\s*≤\s*(\d+(?:\.\d+)?)/ => 'Kernel.≤(\1, \2)',
    /(\d+(?:\.\d+)?)\s*≠\s*(\d+(?:\.\d+)?)/ => 'Kernel.≠(\1, \2)',
    /(\d+(?:\.\d+)?)\s*≈\s*(\d+(?:\.\d+)?)/ => 'Kernel.≈(\1, \2)',
    /√\s*(\d+(?:\.\d+)?)/ => 'Kernel.√(\1)',
    /∛\s*(\d+(?:\.\d+)?)/ => 'Kernel.∛(\1)',
    /∜\s*(\d+(?:\.\d+)?)/ => 'Kernel.∜(\1)',
    /！\s*(\d+)/ => 'Kernel.！(\1)'
  }.freeze

  def self.transform_and_eval(expression)
    ruby_code = expression.dup

    TRANSFORMATIONS.each do |pattern, replacement|
      ruby_code.gsub!(pattern, replacement)
    end

    puts "📝 Original: #{expression}"
    puts "🔄 Transformed: #{ruby_code}"

    result = eval(ruby_code)
    puts "📊 Result: #{result}"
    result
  end
end

puts "\n🧪 TESTING DIFFERENT PARSER APPROACHES:"
puts "=" * 45

puts "\n1️⃣ STRING TRANSFORMATION APPROACH:"
puts "=" * 40

test_cases = [
  "10 ≥ 5",
  "5 ≤ 10",
  "5 ≠ 3",
  "3.14159 ≈ 3.14160",
  "√ 49",
  "∛ 27",
  "∜ 16",
  "！ 5"
]

test_cases.each do |test|
  puts "\nTesting: #{test}"
  StringTransformer.transform_and_eval(test)
end

puts "\n2️⃣ COMPILED RUBY CODE APPROACH:"
puts "=" * 35

module Kernel
  def notation_compile(expression)
    ruby_code = expression.dup

    StringTransformer::TRANSFORMATIONS.each do |pattern, replacement|
      ruby_code.gsub!(pattern, replacement)
    end

    # Return a proc that can be called later
    proc { eval(ruby_code) }
  end

  def notation_eval(expression)
    notation_compile(expression).call
  end
end

puts "\nCompiled notation examples:"
compiled_expr = notation_compile("10 ≥ 5")
puts "Compiled expression result: #{compiled_expr.call}"

puts "Direct evaluation: #{notation_eval("√ 49")}"

puts "\n📊 PARSER COMPARISON SUMMARY:"
puts "=" * 35
puts "1. ✅ RACC - Most powerful, traditional parser generator"
puts "2. ✅ Treetop - PEG parser, good for DSLs"
puts "3. ✅ String transformation - Simple and fast"
puts "4. ✅ Parslet - Good balance of power and simplicity"
puts "5. ⚠️  Parser gem - Better for existing Ruby code transformation"

puts "\n🏆 RECOMMENDATION:"
puts "For your notation gem, use RACC or string transformation:"
puts "• RACC: Most powerful, handles complex expressions"
puts "• String transform: Simple, fast, easy to understand"

puts "\n" + "=" * 60
puts "✨ Multiple parser solutions - choose what fits best! ✨"
