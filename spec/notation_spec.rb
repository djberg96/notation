# frozen_string_literal: true

################################################################
# notation_spec.rb
#
# Specs for the notation library. This should be run via the
# 'rake spec' (or just 'rake') task.
################################################################
require 'rspec'
require 'notation'

RSpec.describe 'Notation' do
  example 'version' do
    expect(Kernel::NOTATION_VERSION).to eq('0.3.0')
    expect(Kernel::NOTATION_VERSION).to be_frozen
  end

  example 'sigma (sum)' do
    expect(Kernel).to respond_to(:∑)
    expect(∑(1, 2, 3)).to eq(6)
    expect(∑([1, 2, 3])).to eq(6)
  end

  example 'pi (product)' do
    expect(Kernel).to respond_to(:∏)
    expect(∏(2, 3, 4)).to eq(24)
    expect(∏([2, 3, 4])).to eq(24)
  end

  example 'square_root' do
    expect(Kernel).to respond_to(:√)
    expect(√(49)).to eq(7.0)
    expect(√(16)).to eq(4.0)
  end

  example 'cube_root' do
    expect(Kernel).to respond_to(:∛)
    expect(∛(27)).to eq(3.0)
    expect(∛(-8)).to eq(-2.0)
  end

  example 'fourth_root' do
    expect(Kernel).to respond_to(:∜)
    expect(∜(16)).to eq(2.0)
    expect(∜(81)).to eq(3.0)
  end

  example 'absolute_value' do
    expect(Kernel).to respond_to(:｜)
    expect(｜(-5)).to eq(5)
    expect(｜(5)).to eq(5)
    expect(｜(0)).to eq(0)
  end

  example 'infinity' do
    expect(Kernel).to respond_to(:∞)
    expect(∞).to eq(Float::INFINITY)
  end

  example 'factorial' do
    expect(Kernel).to respond_to(:！)
    expect(！(5)).to eq(120)
    expect(！(0)).to eq(1)
    expect(！(1)).to eq(1)
    expect { ！(-1) }.to raise_error(ArgumentError)
  end

  example 'delta (difference)' do
    expect(Kernel).to respond_to(:Δ)
    expect(Δ(10, 7)).to eq(3)
    expect(Δ(7, 10)).to eq(3)
  end

  example 'approximately_equal' do
    expect(Kernel).to respond_to(:≈)
    expect(≈(3.14159, 3.14160, 0.001)).to be true
    expect(≈(3.14159, 3.15159, 0.001)).to be false
  end

  example 'not_equal' do
    expect(Kernel).to respond_to(:≠)
    expect(≠(5, 3)).to be true
    expect(≠(5, 5)).to be false
  end

  example 'less_than_or_equal' do
    expect(Kernel).to respond_to(:≤)
    expect(≤(5, 10)).to be true
    expect(≤(5, 5)).to be true
    expect(≤(10, 5)).to be false
  end

  example 'greater_than_or_equal' do
    expect(Kernel).to respond_to(:≥)
    expect(≥(10, 5)).to be true
    expect(≥(5, 5)).to be true
    expect(≥(5, 10)).to be false
  end

  example 'plus_or_minus' do
    expect(Kernel).to respond_to(:±)
    expect(±(5, 2)).to eq([3, 7])
    expect(±(10, 1)).to eq([9, 11])
  end

  example 'degrees_to_radians' do
    expect(Kernel).to respond_to(:°)
    expect(°(180)).to be_within(0.0001).of(Math::PI)
    expect(°(90)).to be_within(0.0001).of(Math::PI / 2)
  end

  example 'percentage' do
    expect(Kernel).to respond_to(:％)
    expect(％(50)).to eq(0.5)
    expect(％(100)).to eq(1.0)
  end

  example 'lambda' do
    expect(λ{ 'hello' }.call).to eq('hello')
  end

  example 'numeric_extensions' do
    expect(10).to respond_to(:≥?)
    expect(10).to respond_to(:≤?)
    expect(10).to respond_to(:≠?)
    expect(10).to respond_to(:≈?)
    
    expect(10.≥?(5)).to be true
    expect(5.≤?(10)).to be true
    expect(5.≠?(3)).to be true
    expect(3.14159.≈?(3.14160, 0.001)).to be true
    
    # Test aliases
    expect(10.greater_equal?(5)).to be true
    expect(5.less_equal?(10)).to be true
    expect(5.not_equal?(3)).to be true
    expect(3.14159.approx_equal?(3.14160, 0.001)).to be true
  end
end
