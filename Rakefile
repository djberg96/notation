require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include("**/*.gem", "**/*.rbc")

namespace :gem do
  desc 'Build the notation gem'
  task :create => [:clean] do
    spec = eval(IO.read('notation.gemspec'))
    Gem::Builder.new(spec).build
  end

  desc 'Install the notation library as a gem'
  task :install => [:create] do
    file = Dir["*.gem"].first
    sh "gem install #{file}"
  end
end

Rake::TestTask.new do |t|
  task :test => :clean
  t.warning = true
  t.verbose = true
  t.ruby_opts << '-Ku' if RUBY_VERSION.to_f < 1.9
end

task :default => :test
