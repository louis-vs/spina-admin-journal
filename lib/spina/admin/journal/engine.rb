# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Registers the plugin with Spina.
      class Engine < ::Rails::Engine
        isolate_namespace Spina::Admin::Journal

        initializer 'spina.admin.journal.assets' do
          Spina.config.importmap.draw do
            pin_all_from Spina::Admin::Journal::Engine.root.join("app/assets/javascripts/spina/admin/journal/controllers"), under: "controllers", to: "spina/admin/journal/controllers"
          end

          Spina.config.tailwind_content.concat(["#{Spina::Admin::Journal::Engine.root}/app/views/**/*.*",
                                                "#{Spina::Admin::Journal::Engine.root}/app/components/**/*.*",
                                                "#{Spina::Admin::Journal::Engine.root}/app/helpers/**/*.*",
                                                "#{Spina::Admin::Journal::Engine.root}/app/assets/javascripts/**/*.js"])
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
