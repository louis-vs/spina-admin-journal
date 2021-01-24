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
        has_many :affiliations, dependent: :destroy
        # @!attribute [rw] institutions
        #   @return [ActiveRecord::Relation] the institutions corresponding to this AuthorName's affiliations
        has_many :institutions, through: :affiliations
        # @!attribute [rw] articles
        #   @return [ActiveRecord::Relation] articles associated through authorships
        has_many :articles, through: :affiliations

        def primary_author_name
          author_names.first.name
        end
      end
    end
  end
end
