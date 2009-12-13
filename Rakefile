require 'rake'
require 'rake/testtask'

desc "Install the notation library (non-gem)"
task :install do
   dest = Config::CONFIG['sitelibdir']
   cp 'lib/notation.rb', dest, :verbose => true
end

desc "Install the notation library as a gem"
task :install_gem do
   ruby 'notation.gemspec'
   file = Dir["*.gem"].first
   sh "gem install #{file}"
end

Rake::TestTask.new do |t|
   t.warning = true
   t.verbose = true
   t.ruby_opts << '-Ku'
end
