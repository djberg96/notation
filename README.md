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
   
λ { puts "hello" } # => "Hello"
∑ [1,2,3]          # => 6
∏ [2,3,4]          # => 24
√ 49               # => 7.0
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
