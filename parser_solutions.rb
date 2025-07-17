#!/usr/bin/env ruby

puts "🔍 Parser Gems for Custom Infix Syntax 🔍"
puts "=" * 50

puts <<~INFO
Here are the most promising parser gems that could help you create
custom syntax for your Unicode operators:

1. 📚 PARSLET - Most Popular DSL Parser
   gem install parslet

   • Perfect for creating domain-specific languages
   • Can parse custom syntax like "10 ≥ 5"
   • Well-documented with many examples
   • Used by many Ruby projects for custom syntax

2. 🔧 TREETOP - PEG Parser Generator
   gem install treetop

   • Grammar-based parser generator
   • Can handle complex syntax rules
   • Good for mathematical expressions
   • Generates Ruby code from grammar files

3. ⚡ RACC - LALR Parser Generator
   Part of Ruby standard library

   • More traditional parser generator
   • Like yacc/bison for Ruby
   • Good for complex grammars
   • Built into Ruby

4. 🎯 PARSER (Ruby AST Parser)
   gem install parser

   • Used by RuboCop and many tools
   • Can create custom AST transformations
   • Good for Ruby-like syntax extensions

5. 🧮 REGEXP_PARSER - Advanced Regex
   gem install regexp_parser

   • For simpler pattern-based parsing
   • Good for mathematical expressions
   • Less overhead than full parsers

RECOMMENDED APPROACH FOR YOUR PROJECT:
Use Parslet to create a mini-language that compiles to Ruby method calls.

Example workflow:
"10 ≥ 5" → Parslet parser → Ruby AST → "≥(10, 5)"

This would let users write:
notation_eval("10 ≥ 5")  # => true
notation_eval("5 ≤ 10")  # => true
INFO

puts "\n🚀 PROOF OF CONCEPT:"
puts "Let me show you a simple example using basic parsing..."

# Simple proof of concept without external gems
class NotationParser
  def self.parse(expression)
    # Simple regex-based approach for proof of concept
    case expression.strip
    when /^(\d+(?:\.\d+)?)\s*≥\s*(\d+(?:\.\d+)?)$/
      left, right = $1.to_f, $2.to_f
      puts "Parsing: #{left} ≥ #{right}"
      "≥(#{left}, #{right})"
    when /^(\d+(?:\.\d+)?)\s*≤\s*(\d+(?:\.\d+)?)$/
      left, right = $1.to_f, $2.to_f
      puts "Parsing: #{left} ≤ #{right}"
      "≤(#{left}, #{right})"
    when /^(\d+(?:\.\d+)?)\s*≠\s*(\d+(?:\.\d+)?)$/
      left, right = $1.to_f, $2.to_f
      puts "Parsing: #{left} ≠ #{right}"
      "≠(#{left}, #{right})"
    else
      raise "Cannot parse: #{expression}"
    end
  end

  def self.eval(expression)
    require_relative 'lib/notation'
    ruby_code = parse(expression)
    puts "Generated Ruby: #{ruby_code}"
    result = Kernel.eval(ruby_code)
    puts "Result: #{result}"
    result
  end
end

puts "\nTesting basic parser:"
begin
  NotationParser.eval("10 ≥ 5")
  NotationParser.eval("5 ≤ 10")
  NotationParser.eval("5 ≠ 3")
rescue => e
  puts "Error: #{e.message}"
end

puts <<~NEXT_STEPS

🎯 NEXT STEPS:
1. Choose a parser gem (Parslet recommended)
2. Define grammar for your Unicode operators
3. Create a notation_eval() method in your gem
4. Users can write: notation_eval("10 ≥ 5")

This gives you true infix syntax within a controlled environment!

📖 LEARNING RESOURCES:
• Parslet tutorial: https://kschiess.github.io/parslet/
• Treetop guide: https://github.com/cjheath/treetop
• Ruby parser ecosystem: https://github.com/ruby/parser

Would you like me to create a full Parslet implementation?
NEXT_STEPS

puts "\n" + "=" * 50
