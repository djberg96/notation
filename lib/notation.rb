# frozen_string_literal: true

# Extend the core Kernel module
module Kernel
  # Version of the notation library
  NOTATION_VERSION = '0.3.0'

  # Make lambda a true lambda
  #
  # Example:
  #   λ { puts 'Hello' }.call => 'Hello'
  #
  alias λ proc

  # Sigma, i.e. the sum of all elements.
  # Improved to handle arrays and individual arguments
  #
  # Examples:
  #   ∑ [1,2,3] => 6
  #   ∑ 1,2,3   => 6
  #
  def ∑(*args)
    args = args.first if args.length == 1 && args.first.respond_to?(:each)
    args.inject(0) { |sum, element| sum + element }
  end

  # Pi product, i.e. the product of all elements.
  # Improved to handle arrays and individual arguments
  #
  # Examples:
  #   ∏ [2,3,4] => 24
  #   ∏ 2,3,4   => 24
  #
  def ∏(*args)
    args = args.first if args.length == 1 && args.first.respond_to?(:each)
    args.inject(1) { |product, element| product * element }
  end

  # Square root
  #
  # Example:
  #   √ 49 => 7.0
  #
  def √(value)
    Math.sqrt(value)
  end

  # Cube root
  #
  # Example:
  #   ∛ 27 => 3.0
  #
  def ∛(value)
    value < 0 ? -((-value) ** (1.0/3)) : value ** (1.0/3)
  end

  # Fourth root
  #
  # Example:
  #   ∜ 16 => 2.0
  #
  def ∜(value)
    value ** (1.0/4)
  end

  # Absolute value
  #
  # Example:
  #   ｜-5｜ => 5
  #
  def ｜(value)
    value.abs
  end

  # Infinity constant
  #
  # Example:
  #   ∞ => Float::INFINITY
  #
  def ∞
    Float::INFINITY
  end

  # Factorial
  #
  # Example:
  #   ！ 5 => 120
  #
  def ！(n)
    raise ArgumentError, 'Factorial is only defined for non-negative integers' if n < 0
    return 1 if n == 0 || n == 1
    (2..n).inject(1) { |result, i| result * i }
  end

  # Delta (difference between two values)
  #
  # Example:
  #   Δ 10, 7 => 3
  #
  def Δ(a, b)
    (a - b).abs
  end

  # Approximately equal (within epsilon)
  #
  # Example:
  #   ≈ 3.14159, 3.14160, 0.001 => true
  #
  def ≈(a, b, epsilon = 1e-10)
    (a - b).abs < epsilon
  end

  # Not equal
  #
  # Example:
  #   ≠ 5, 3 => true
  #
  def ≠(a, b)
    a != b
  end

  # Less than or equal
  #
  # Example:
  #   ≤ 5, 10 => true
  #
  def ≤(a, b)
    a <= b
  end

  # Greater than or equal
  #
  # Example:
  #   ≥ 10, 5 => true
  #
  def ≥(a, b)
    a >= b
  end

  # Plus or minus (returns array with both values)
  #
  # Example:
  #   ± 5, 2 => [3, 7]
  #
  def ±(value, delta)
    [value - delta, value + delta]
  end

  # Degrees to radians
  #
  # Example:
  #   ° 180 => 3.141592653589793
  #
  def °(degrees)
    degrees * Math::PI / 180
  end

  # Percentage (divide by 100)
  #
  # Example:
  #   ％ 50 => 0.5
  #
  def ％(value)
    value / 100.0
  end
end
