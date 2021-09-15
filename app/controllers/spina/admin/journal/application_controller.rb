# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Custom controller for journal plugin. Sets the layout and adds a flash type.
      class ApplicationController < AdminController
        helper ::Spina::Engine.routes.url_helpers

        add_flash_types :success

        layout :admin_layout, only: %i[new edit]

        before_action :set_locale

        private

        def admin_layout
          'spina/admin/admin'
        end

        def set_locale
          @locale = params[:locale] || I18n.default_locale
        end
      end
    end
  end
end
