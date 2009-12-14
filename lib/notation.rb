# Run with -Ku

module Kernel
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
