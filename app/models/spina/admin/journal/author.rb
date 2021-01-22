# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Authors are collections of AuthorNames.
      #
      # Since people can have multiple names, titles, institutions, etc., this is all
      # handled by the {AuthorName} record. This record groups said records together,
      # in order that a coherent oeuvre of a single author be identified.
      class Author < ApplicationRecord
        # @!attribute [rw] author_names
        #   @return [ActiveRecord::Relation] names of the author
        #   @note Deleting an author may not leave any orphan author_names. These must be
        #         destroyed earlier by the program, to confirm that there are no articles that
        #         will be left with single parents.
        has_many :author_names, dependent: :restrict_with_error
      end
    end
  end
end
