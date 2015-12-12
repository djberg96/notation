require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include("**/*.gem", "**/*.rbc")

namespace :gem do
  desc 'Build the notation gem'
  task :create => [:clean] do
    require 'rubygems/package'
    spec = eval(IO.read('notation.gemspec'))
    spec.signing_key = File.join(Dir.home, '.ssh', 'gem-private_key.pem')
    Gem::Package.build(spec, true)
  end

  desc 'Install the notation library as a gem'
  task :install => [:create] do
    file = Dir["*.gem"].first
    sh "gem install -l #{file}"
  end
end

Rake::TestTask.new do |t|
  task :test => :clean
  t.warning = true
  t.verbose = true
  t.ruby_opts << '-Ku' if RUBY_VERSION.to_f < 1.9
end

task :default => :test
