[![Ruby](https://github.com/djberg96/notation/actions/workflows/ruby.yml/badge.svg)](https://github.com/djberg96/notation/actions/workflows/ruby.yml)

## Description
Unicode methods for Ruby.

## Installation
`gem install notation`

## Installing the Trusted Cert

`gem cert --add <(curl -Ls https://raw.githubusercontent.com/djberg96/notation/main/certs/djberg96_pub.pem)`

## Synopsis
```ruby
require 'notation'

# Lambda notation
λ { puts "hello" }         # => "Hello"

# Mathematical operations
∑ [1,2,3]                  # => 6 (sum)
∏ [2,3,4]                  # => 24 (product)
√ 49                       # => 7.0 (square root)
∛ 27                       # => 3.0 (cube root)
∜ 16                       # => 2.0 (fourth root)
｜-5｜                      # => 5 (absolute value)
！ 5                       # => 120 (factorial)

# Comparison operations
≈ 3.14159, 3.14160, 0.001  # => true (approximately equal)
≠ 5, 3                     # => true (not equal)
≤ 5, 10                    # => true (less than or equal)
≥ 10, 5                    # => true (greater than or equal)

# Utility functions
Δ 10, 7                    # => 3 (delta/difference)
± 5, 2                     # => [3, 7] (plus or minus)
° 180                      # => 3.14159... (degrees to radians)
％ 50                      # => 0.5 (percentage)
∞                          # => Float::INFINITY
```

## Author's Notes
This library was inspired by the programming language Fortress, an offshoot
of Fortran, created by Sun. Fortress supports unicode operators baked into
the language.

## Restrictions
The ability to add unicode methods is limited to method names that have
no receiver. This is a limitation of the Ruby parser.

## Copyright
(C) 2009-2021 Daniel J. Berger
All Rights Reserved

## License
Apache-2.0

## Author
Daniel Berger
