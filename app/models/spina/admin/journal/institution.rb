# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Simple model for an institution. Associated with AuthorNames via affiliations.
      #
      # - Validates
      # Presence:: {#name}
      # Uniqueness:: {#name}
      class Institution < ApplicationRecord
        # @!attribute [rw] name
        #   @return [String]
        # @!attribute [rw] affiliations
        #   @return [ActiveRecord::Relation] the affiliations held at the institution
        has_many :affiliations, dependent: :nullify
        # @!attribute [rw] author_names
        #   @return [ActiveRecord::Relation] associated author names
        has_many :author_names, through: :affiliations

        validates :name, presence: true, uniqueness: { case_sensitive: false }
      end
    end
  end
end
