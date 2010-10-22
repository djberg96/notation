require 'rake'
require 'rake/testtask'
include Config

namespace :gem do
  desc 'Clean any .gem or .rbc files'
  task :clean do
    Dir['*.gem'].each{ |f| File.delete(f) }
    Dir['**/*.rbc'].each{ |f| File.delete(f) }
  end

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
  task :test => 'gem:clean'
  t.warning = true
  t.verbose = true
  t.ruby_opts << '-Ku'
end

task :default => :test
