# frozen_string_literal: true

module Spina
  module Admin
    module Journal
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
