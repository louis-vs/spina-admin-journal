# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Displays a message indicating that a {ListComponent} has no items.
      class EmptyListComponent < ApplicationComponent
        def initialize(message: t('spina.admin.journal.empty_list'))
          @message = message
        end
      end
    end
  end
end
