require 'bundler'
require 'rake/testtask'
Bundler::GemHelper.install_tasks

desc 'Unit Rests'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

