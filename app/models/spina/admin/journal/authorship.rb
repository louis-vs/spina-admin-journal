# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Joins Articles and Affiliations
      # @see Article
      # @see Affiliation
      class Authorship < ApplicationRecord
        # @!attribute [rw] article
        #   @return [ActiveRecord::Relation] the associated article
        belongs_to :article
        # @!attribute [rw] author_name
        #   @return [ActiveRecord::Relation] the associated affiliation of an author of the article
        belongs_to :affiliation
        # @!attribute [rw] position
        #   @return [Integer] used to order the affiliations for each article

        before_validation :set_default_position, unless: :persisted?
        validates :position, presence: true, uniqueness: { scope: :article_id }

        scope :sorted_within_article, -> { order(position: :asc) }

        private

        def set_default_position
          return if article.authorships.sorted_within_article.last.nil?

          self.position = article.authorships.sorted_within_article.last.position + 1
        end
      end
    end
  end
end
