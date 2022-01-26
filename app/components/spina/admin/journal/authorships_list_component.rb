# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # A list of authorships. Sortable when displayed in their corresponding article.
      class AuthorshipsListComponent < ListComponent
        attr_reader :sortable

        def initialize(authorships:, sortable: false)
          @authorships = authorships
          @sortable = sortable
        end

        def before_render
          @list_items = generate_list_items(@authorships)
        end

        def call
          render ListComponent.new(list_items: @list_items,
                                   sortable: sortable?,
                                   sort_path: generate_sort_path)
        end

        def sortable?
          sortable
        end

        private

        def generate_list_items(authorships)
          authorships.map do |authorship|
            { id: authorship.id,
              label: authorship.affiliation.reversed_name,
              path: helpers.spina.edit_admin_journal_author_path(authorship.affiliation.author) }
          end
        end

        def generate_sort_path
          @authorships.any? ? helpers.spina.sort_admin_journal_authors_path(@authorships.first.article.id) : ''
        end
      end
    end
  end
end
