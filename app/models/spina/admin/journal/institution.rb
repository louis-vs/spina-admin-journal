# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Record for an institution. Associated with {Author}s via {Affiliation}s.
      #
      # === Validators
      # Presence:: {#name}
      # Uniqueness:: {#name}
      #
      # === Scopes
      # sorted:: sort institutions in alphabetical order
      #
      # @see Affiliation
      class Institution < ApplicationRecord
        # @!attribute [rw] name
        #   @return [String]
        # @!attribute [rw] affiliations
        #   @return [ActiveRecord::Relation] the affiliations held at the institution
        has_many :affiliations, dependent: :destroy
        # @!attribute [rw] authors
        #   @return [ActiveRecord::Relation] associated authors
        has_many :authors, through: :affiliations

        validates :name, presence: true, uniqueness: { case_sensitive: false }

        scope :sorted, -> { order(name: :asc) }
      end
    end
  end
end
