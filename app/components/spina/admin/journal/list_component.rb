# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # A generic implementation of a list, resembling Spina's page list.
      class ListComponent < ApplicationComponent
        attr_reader :sortable

        def initialize(list_items:, sortable: false, sort_path: '')
          @sortable = sortable
          @list_items = list_items
          @sort_path = sort_path
        end

        def sortable?
          sortable
        end
      end
    end
  end
end
