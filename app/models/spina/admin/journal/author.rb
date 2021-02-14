# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Authors are collections of Affiliations.
      #
      # Since people can have multiple names, titles, institutions, etc., this is all
      # handled by the {Affiliation} record. This record groups said records together,
      # in order that a coherent oeuvre of a single author be identified.
      class Author < ApplicationRecord
        # @!attribute [rw] affiliations
        #   @return [ActiveRecord::Relation] directly associated affiliations
        has_many :affiliations, inverse_of: :author, dependent: :destroy
        accepts_nested_attributes_for :affiliations
        # @!attribute [rw] institutions
        #   @return [ActiveRecord::Relation] the institutions corresponding to this AuthorName's affiliations
        has_many :institutions, through: :affiliations
        # @!attribute [rw] articles
        #   @return [ActiveRecord::Relation] articles associated through authorships
        has_many :articles, through: :affiliations

        validate :must_have_one_primary_affiliation

        # @!attribute [r] primary_affiliation
        #   @return [ActiveRecord::Relation] the author's primary affiliation
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
