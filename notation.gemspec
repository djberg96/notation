require 'rubygems'

Gem::Specification.new do |gem|
  gem.name      = 'notation'
  gem.version   = '0.1.1'
  gem.author    = 'Daniel J. Berger'
  gem.email     = 'djberg96@gmail.com'
  gem.homepage  = 'http://www.rubyforge.org/projects/shards'
  gem.summary   = 'Unicode symbols that can be used as methods.'
  gem.test_file = 'test/test_notation.rb'
  gem.files     = Dir['**/*'].delete_if{ |item| item.include?('git') }

  gem.extra_rdoc_files  = ['CHANGES', 'README', 'MANIFEST']
  gem.rubyforge_project = 'shards'

  gem.description = <<-EOF
    The notation library provides unicode symbols that you can use as
    methods instead of using standard method names.
  EOF
end
