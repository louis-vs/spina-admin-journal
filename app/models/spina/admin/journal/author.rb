# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Authors are collections of {Affiliation}s.
      #
      # Since people can have multiple names, titles, institutions, etc., these details are all
      # handled by the {Affiliation} record. This record groups said records together, in order
      # that a coherent oeuvre of a single author be identified, which is more user-friendly.
      #
      # @note An author must have at least one Affiliation with +status: primary+, else validation
      #       will fail.
      #
      # @see Affiliation
      class Author < ApplicationRecord
        # @!attribute [rw] affiliations
        #   @return [ActiveRecord::Relation] Directly associated {Affiliation}s.
        has_many :affiliations, inverse_of: :author, dependent: :destroy
        accepts_nested_attributes_for :affiliations
        # @!attribute [rw] institutions
        #   @return [ActiveRecord::Relation] The {Institution}s corresponding to this Author's affiliations.
        has_many :institutions, through: :affiliations
        # @!attribute [rw] articles
        #   @return [ActiveRecord::Relation] {Article}s associated through authorships.
        has_many :articles, through: :affiliations

        validate :must_have_one_primary_affiliation
        validates :orcid, format: { with: /\A((\d{4}-){3}\d{3}(\d|X))?\z/ }

        # @!attribute [r] primary_affiliation
        #   @return [ActiveRecord::Relation] The author's primary affiliation.
        def primary_affiliation
          affiliations.primary.first || Affiliation.new(status: :primary)
        end

        private

        def must_have_one_primary_affiliation
          return if !affiliations.nil? && affiliations.any? \
            && (affiliations.count { |affiliation| affiliation.status == 'primary' } == 1)

          errors.add :affiliations, 'must have at least one primary affiliation'
        end
      end
    end
  end
end
