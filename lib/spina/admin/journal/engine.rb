# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Registers the plugin with Spina.
      class Engine < ::Rails::Engine
        isolate_namespace Spina::Admin::Journal

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
