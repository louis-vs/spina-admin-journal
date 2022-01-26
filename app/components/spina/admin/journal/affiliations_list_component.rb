# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      class AffiliationsListComponent < ListComponent
        def initialize(affiliations:)
          @affiliations = affiliations
        end

        def before_render
          @list_items = generate_list_items(@affiliations)
        end

        def call
          render ListComponent.new(list_items: @list_items, sortable: false)
        end

        private

        def generate_list_items(affiliations)
          affiliations.map do |affiliation|
            { id: affiliation.id,
              label: affiliation.reversed_name,
              path: helpers.spina.edit_admin_journal_author_path(affiliation.author) }
          end
        end
      end
    end
  end
end
