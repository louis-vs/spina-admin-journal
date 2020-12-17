# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # The Author record effectively serves as an inverse join between affiliations
      # and names. In the entropic flux of reality, this serves as a point of
      # constancy.
      class Author < ApplicationRecord
        # @!attribute [rw] author_names
        #   @return [ActiveRecord::Relation] names of the author
        #   @note Deleting an author may not leave any orphan author_names. These must be
        #         destroyed earlier by the program, to confirm that there are no articles that
        #         will be left with single parents.
        has_many :author_names, dependent: :restrict_with_error
        # @!attribute [rw] affiliations
        #   @return [ActiveRecord::Relation] the authors institutional affiliations
        has_many :affiliations, dependent: :destroy
      end
    end
  end
end
