module Spina
  module Admin
    module Journal
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