# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # A generic list item that is only intended to be called by {ListItemComponent}.
      class ListItemComponent < ApplicationComponent
        attr_reader :sortable

        def initialize(id:, label:, path:, sortable: false)
          @label = label
          @id = id
          @path = path
          @sortable = sortable
        end

        def sortable?
          sortable
        end
      end
    end
  end
end
