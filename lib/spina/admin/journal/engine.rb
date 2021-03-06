# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Registers the plugin with Spina.
      class Engine < ::Rails::Engine
        config.before_initialize do
          ::Spina::Plugin.register do |plugin|
            plugin.name = 'journal'
            plugin.namespace = 'journal'
          end
        end
      end
    end
  end
end
