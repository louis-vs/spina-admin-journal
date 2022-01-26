# frozen_string_literal: true

module Spina
  module Admin
    module Journal
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
                                   sort_path: helpers.spina.sort_admin_journal_authors_path(@authorships.first.article.id))
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
      end
    end
  end
end
