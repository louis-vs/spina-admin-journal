# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Joins Articles and Affiliations
      # @see Article, Affiliation
      class Authorship < ApplicationRecord
        # @!attribute [rw] article
        #   @return [ActiveRecord::Relation] the associated article
        belongs_to :article
        # @!attribute [rw] author_name
        #   @return [ActiveRecord::Relation] the associated affiliation of an author of the article
        belongs_to :affiliation
      end
    end
  end
end
