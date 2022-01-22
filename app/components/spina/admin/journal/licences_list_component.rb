# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      class LicencesListComponent < ListComponent
        def initialize(licences:)
          @licences = licences
        end

        def before_render
          @list_items = generate_list_items(@licences)
        end

        def call
          render ListComponent.new(list_items: @list_items, sortable: false)
        end

        private

        def generate_list_items(licences)
          licences.map do |licence|
            { id: licence.id,
              label: licence.name,
              path: helpers.spina.edit_admin_journal_licence_path(licence) }
          end
        end
      end
    end
  end
end
