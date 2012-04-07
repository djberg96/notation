# encoding: utf-8

# Run with -Ku if using Ruby 1.8.

module Kernel
  # Version of the notation library
  NOTATION_VERSION = '0.1.1'

  # Make lambda a true lambda
  #
  # Example:
  #    λ { puts 'Hello' }.call => 'Hello'
  #
  alias λ proc

  # Sigma, i.e. the sum of all elements.
  #
  # Example:
  #    ∑ [1,2,3] => 6
  #
  def ∑(*args)
    sum = 0
    args.each{ |e| sum += e }
    sum
  end

  # Square root
  #
  # Example:
  #   √ 49 => 7.0
  #
  def √(root)
    Math.sqrt(root)
  end
end
