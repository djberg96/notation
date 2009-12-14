require 'rake'
require 'rake/testtask'
include Config

desc "Install the notation library"
task :install_lib do
  cp 'lib/notation.rb', CONFIG['sitelibdir'], :verbose => true
end

desc 'Build the notation gem'
task :gem do
  spec = eval(IO.read('notation.gemspec'))
  Gem::Builder.new(spec).build
end

desc 'Install the notation library as a gem'
task :install_gem => [:gem] do
  file = Dir["*.gem"].first
  sh "gem install #{file}"
end

Rake::TestTask.new do |t|
  t.warning = true
  t.verbose = true
  t.ruby_opts << '-Ku'
end
