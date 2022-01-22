# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      class AuthorsListComponent < ListComponent
        def initialize(authors:)
          @authors = authors
        end

        def before_render
          @list_items = generate_list_items(@authors)
        end

        def call
          render ListComponent.new(list_items: @list_items, sortable: false)
        end

        private

        def generate_list_items(authors)
          authors.map do |author|
            { id: author.id,
              label: generate_label(author),
              path: helpers.spina.edit_admin_journal_author_path(author) }
          end
        end

        def generate_label(author)
          t 'spina.admin.journal.authors.name_institution', name: author.primary_affiliation.name,
                                                            institution: author.primary_affiliation.institution.name
        end
      end
    end
  end
end
