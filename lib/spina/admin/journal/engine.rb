# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Registers the plugin with Spina.
      class Engine < ::Rails::Engine
        isolate_namespace Spina::Admin::Journal

        config.to_prepare do
          Spina.configure do |config|
            config.tailwind_content << "#{Spina::Admin::Journal::Engine.root}/app/views/**/*.*"
            config.tailwind_content << "#{Spina::Admin::Journal::Engine.root}/app/components/**/*.*"
            config.tailwind_content << "#{Spina::Admin::Journal::Engine.root}/app/helpers/**/*.*"
            config.tailwind_content << "#{Spina::Admin::Journal::Engine.root}/app/assets/javascripts/**/*.js"
            config.tailwind_content << "#{Spina::Admin::Journal::Engine.root}/app/**/application.tailwind.css"
          end
          puts Spina.config.tailwind_content
        end

        config.before_initialize do
          ::Spina::Plugin.register do |plugin|
            plugin.name = 'journal'
            plugin.namespace = 'journal'
          end
        end

        config.after_initialize do
          Spina::Part.register Spina::Parts::Admin::Journal::PageRange
        end
      end
    end
  end
end
