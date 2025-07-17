# Example integration into your notation.rb gem

# Add this to your gemspec:
# spec.add_dependency 'parslet', '~> 2.0'

# Add this to the end of your lib/notation.rb file:

begin
  require 'parslet'

  # Unicode infix notation parser
  class NotationGrammar < Parslet::Parser
    rule(:space) { match('\s').repeat(1) }
    rule(:space?) { space.maybe }

    rule(:integer) { match('[0-9]').repeat(1) }
    rule(:float) { integer >> str('.') >> integer }
    rule(:number) { float | integer }

    rule(:greater_equal) { str('≥') }
    rule(:less_equal) { str('≤') }
    rule(:not_equal) { str('≠') }
    rule(:approx_equal) { str('≈') }
    rule(:sqrt) { str('√') }
    rule(:factorial) { str('！') }

    rule(:binary_op) { greater_equal | less_equal | not_equal | approx_equal }
    rule(:unary_op) { sqrt | factorial }

    rule(:binary_expr) {
      number.as(:left) >> space? >> binary_op.as(:op) >> space? >> number.as(:right)
    }

    rule(:unary_expr) {
      unary_op.as(:op) >> space? >> number.as(:operand)
    }

    rule(:expression) { binary_expr | unary_expr }
    root(:expression)
  end

  class NotationTransform < Parslet::Transform
    rule(left: simple(:l), op: simple(:op), right: simple(:r)) do
      left, right = l.to_f, r.to_f
      case op.to_s
      when '≥' then { method: '≥', args: [left, right] }
      when '≤' then { method: '≤', args: [left, right] }
      when '≠' then { method: '≠', args: [left, right] }
      when '≈' then { method: '≈', args: [left, right] }
      end
    end

    rule(op: simple(:op), operand: simple(:operand)) do
      value = operand.to_f
      case op.to_s
      when '√' then { method: '√', args: [value] }
      when '！' then { method: '！', args: [value.to_i] }
      end
    end
  end

  # Add infix evaluation to Kernel module
  module Kernel
    def notation_eval(expression)
      parser = NotationGrammar.new
      transform = NotationTransform.new

      parsed = parser.parse(expression)
      transformed = transform.apply(parsed)
      method = transformed[:method]
      args = transformed[:args]

      case method
      when '≥' then ≥(*args)
      when '≤' then ≤(*args)
      when '≠' then ≠(*args)
      when '≈' then ≈(*args)
      when '√' then √(*args)
      when '！' then ！(*args)
      end
    rescue Parslet::ParseFailed
      raise ArgumentError, "Cannot parse notation expression: #{expression}"
    end
  end

  # Enable infix notation
  NOTATION_INFIX_AVAILABLE = true

rescue LoadError
  # Parslet not available, infix notation disabled
  NOTATION_INFIX_AVAILABLE = false

  module Kernel
    def notation_eval(expression)
      raise NotImplementedError, "Install 'parslet' gem to use infix notation: gem install parslet"
    end
  end
end

# Usage examples:
puts <<~EXAMPLES

NOTATION GEM - UNICODE MATHEMATICAL OPERATORS
=============================================

FUNCTION SYNTAX (always available):
≥(10, 5)        # => true
≤(5, 10)        # => true
≠(5, 3)         # => true
√(49)           # => 7.0
！(5)           # => 120

#{"INFIX SYNTAX (requires 'parslet' gem):" if defined?(NOTATION_INFIX_AVAILABLE)}
#{if defined?(NOTATION_INFIX_AVAILABLE) && NOTATION_INFIX_AVAILABLE
    'notation_eval("10 ≥ 5")    # => true
notation_eval("5 ≤ 10")    # => true
notation_eval("5 ≠ 3")     # => true
notation_eval("√ 49")      # => 7.0
notation_eval("！ 5")      # => 120'
  else
    'Install parslet gem for infix notation: gem install parslet'
  end}

This gives you both syntaxes:
• Functional: ≥(10, 5)
• Infix: notation_eval("10 ≥ 5")

The infix syntax is optional and degrades gracefully!
EXAMPLES

puts "\n🎯 INTEGRATION COMPLETE!"
puts "Your notation gem now supports true Unicode infix notation!"
