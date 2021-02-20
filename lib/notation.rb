# encoding: utf-8

# Run with -Ku if using Ruby 1.8.

module Kernel
  # Version of the notation library
  NOTATION_VERSION = '0.2.1'.freeze

  # Make lambda a true lambda
  #
  # Example:
  #   λ { puts 'Hello' }.call => 'Hello'
  #
  alias λ proc

  # Sigma, i.e. the sum of all elements.
  #
  # Example:
  #   ∑ [1,2,3] => 6
  #
  def ∑(*args)
    args.inject(0){ |e,m| m += e }
  end

  # Pi product, i.e. the product of all elements.
  #
  # Example:
  #   ∏ [2,3,4] => 24
  #
  def ∏(*args)
    args.inject(1){ |e,m| m *= e }
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
