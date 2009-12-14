#######################################################################
# test_notation.rb
#
# Test case for the notation library. This should be run via the
# 'rake test' task.
#######################################################################
require 'test/unit'
require 'notation'

class TC_Notation < Test::Unit::TestCase
  def test_sigma
    assert_respond_to(Kernel, :∑)
    assert_equal(6, ∑(1,2,3))
  end
   
  def test_square_root
    assert_respond_to(Kernel, :√)
    assert_equal(7.0, √(49))
  end
   
  def test_lambda
    assert_equal('hello', λ { 'hello' }.call)
  end
end
