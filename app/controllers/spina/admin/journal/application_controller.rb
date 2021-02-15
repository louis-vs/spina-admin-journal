# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Custom controller for journal plugin. Sets the layout and adds a flash type.
      class ApplicationController < AdminController
        add_flash_types :success

        layout :admin_layout, only: %i[new edit]

        private

        def admin_layout
          'spina/admin/admin'
        end
      end
    end
  end
end
