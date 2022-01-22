# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      class InstitutionsListComponent < ListComponent
        def initialize(institutions:)
          @institutions = institutions
        end

        def before_render
          @list_items = generate_list_items(@institutions)
        end

        def call
          render ListComponent.new(list_items: @list_items, sortable: false)
        end

        private

        def generate_list_items(institutions)
          institutions.map do |institution|
            { id: institution.id,
              label: institution.name,
              path: helpers.spina.edit_admin_journal_institution_path(institution.id) }
          end
        end
      end
    end
  end
end
