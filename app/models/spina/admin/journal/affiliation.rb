# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Joins an Institution with a particular AuthorName.
      # @see Institution, AuthorName
      class Affiliation < ApplicationRecord
        # @!attribute [rw] author_name
        #   @return [ActiveRecord::Relation] the AuthorName whose affiliation this record holds
        belongs_to :author_name
        # @!attribute [rw] insttution
        #   @return [ActiveRecord::Relation] the Institution to which the author is affiliated
        belongs_to :institution
      end
    end
  end
end
