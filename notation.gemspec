require 'rubygems'

Gem::Specification.new do |spec|
  spec.name       = 'notation'
  spec.version    = '0.2.0'
  spec.author     = 'Daniel J. Berger'
  spec.email      = 'djberg96@gmail.com'
  spec.license    = 'Apache-2.0'
  spec.homepage   = 'http://github.com/djberg96/notation'
  spec.summary    = 'Unicode symbols that can be used as methods.'
  spec.test_files = Dir['spec/*_spec.rb']
  spec.files      = Dir['**/*'].reject{ |f| f.include?('git') }
  spec.cert_chain = Dir['certs/*']

  spec.add_development_dependency('rake')

  spec.description = <<-EOF
    The notation library provides unicode symbols that you can use as
    methods instead of using standard method names.
  EOF

  spec.metadata = {
    'homepage_uri'      => 'https://github.com/djberg96/notation',
    'bug_tracker_uri'   => 'https://github.com/djberg96/notation/issues',
    'changelog_uri'     => 'https://github.com/djberg96/notation/blob/master/CHANGES.md',
    'documentation_uri' => 'https://github.com/djberg96/notation/wiki',
    'source_code_uri'   => 'https://github.com/djberg96/notation',
    'wiki_uri'          => 'https://github.com/djberg96/notation/wiki'
  }
end
