# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Record for the names of authors (since authors can plausibly have multiple,
      # e.g. variants). This is the record that is associated with Articles themselves.
      #
      # - Validators
      # Presence:: {#name}
      class AuthorName < ApplicationRecord
        # @! attribute [rw] author
        #   @return [ActiveRecord::Relation] the author of whom this is a(/the) name
        belongs_to :author

        # @! attribute [rw] authorships
        #   @return [ActiveRecord::Relation] directly associated authorships
        #   @note an AuthorName cannot be deleted if it has dependent authorships.
        #         This scenario must be handled in deletion code, for instance by
        #         automatically reassigning authors or by prompting the user.
        has_many :authorships, dependent: :restrict_with_error
        # @! attribute [rw] articles
        #   @return [ActiveRecord::Relation] articles associated through authorships
        has_many :articles, through: :authorships

        # @! attribute [rw] name
        #   @return [String] the name of the author
        validates :name, presence: true
      end
    end
  end
end
