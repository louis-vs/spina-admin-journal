# frozen_string_literal: true

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'yard'

YARD::Rake::YardocTask.new(:yardoc) do |t|
  t.files = ['lib/**/*.rb', 'app/**/*.rb']
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
