# frozen_string_literal: true

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'sdoc'
require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc/rdoc'
  rdoc.title    = 'Spina::Admin::Journal'
  rdoc.main = 'README.md'
  rdoc.options << '--line-numbers'
  rdoc.options << '--format=sdoc'
  rdoc.rdoc_files.include('README.md', 'lib/**/*.rb', 'app/**/*.rb')
end

APP_RAKEFILE = File.expand_path('test/dummy/Rakefile', __dir__)
load 'rails/tasks/engine.rake'

load 'rails/tasks/statistics.rake'

require 'bundler/gem_tasks'

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

require 'rubocop/rake_task'

RuboCop::RakeTask.new do |t|
  t.options << '--parallel' if ENV['CI']
end

task default: :test
