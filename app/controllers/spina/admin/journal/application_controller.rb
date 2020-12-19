# frozen_string_literal: true

require_dependency 'spina/application_controller'

module Spina
  module Admin
    module Journal
      # Custom controller for journal plugin
      class ApplicationController < AdminController
        layout :admin_layout, only: %i[new edit]

        private

        def admin_layout
          'spina/admin/admin'
        end
      end
    end
  end
end
