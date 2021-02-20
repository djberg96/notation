# encoding: utf-8
################################################################
# notation_spec.rb
#
# Specs for the notation library. This should be run via the
# 'rake spec' (or just 'rake') task.
################################################################
require 'rspec'
require 'notation'

RSpec.describe "Notation" do
  example "version" do
    expect(Kernel::NOTATION_VERSION).to eq('0.2.1')
    expect(Kernel::NOTATION_VERSION).to be_frozen
  end

  example "sigma" do
    expect(Kernel).to respond_to(:∑)
    expect(∑(1,2,3)).to eq(6)
  end

  example "pi" do
    expect(Kernel).to respond_to(:∏)
    expect(∏(2,3,4)).to eq(24)
  end

  example "square_root" do
    expect(Kernel).to respond_to(:√)
    expect(√(49)).to eq(7.0)
  end

  example "lambda" do
    expect(λ{ 'hello' }.call).to eq('hello')
  end
end
