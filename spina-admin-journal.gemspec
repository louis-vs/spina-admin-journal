# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'spina/admin/journal/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'spina-admin-journal'
  spec.version     = Spina::Admin::Journal::VERSION
  spec.authors     = ['Louis Van Steene']
  spec.email       = ['louisvansteene@gmail.com']
  spec.homepage    = 'https://github.com/louis-vs/spina-admin-journal'
  spec.summary     = 'Academic journal plugin for Spina.'
  spec.description = 'Manage journal submissions and publications with this plugin.'
  spec.license     = 'MIT'
  spec.required_ruby_version = '~> 2.7'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  unless spec.respond_to?(:metadata)
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'mobility', '~> 0.8.13'
  spec.add_dependency 'rails', '~> 6.0'
  spec.add_dependency 'rails-i18n', '~> 6.0'
  spec.add_dependency 'spina', '~> 1.1'

  spec.add_development_dependency 'image_processing', '~> 1.2'
  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'puma', '~> 5.0'
  spec.add_development_dependency 'rubocop', '~> 0.93'
  spec.add_development_dependency 'rubocop-performance', '~> 1.8'
  spec.add_development_dependency 'rubocop-rails', '~> 2.8'
end
