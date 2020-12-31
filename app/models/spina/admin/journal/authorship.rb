# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Joins Articles and AuthorNames
      # @see Article, AuthorName
      class Authorship < ApplicationRecord
        # @!attribute [rw] article
        #   @return [ActiveRecord::Relation] the associated article
        belongs_to :article
        # @!attribute [rw] author_name
        #   @return [ActiveRecord::Relation] the associated name of an author of the article
        belongs_to :author_name
      end
    end
  end
end
