# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      class ListComponent < ApplicationComponent
        attr_reader :sortable

        def initialize(list_items:, sortable: false)
          @sortable = sortable
          @list_items = list_items
        end

        def sortable?
          sortable
        end
      end
    end
  end
end
