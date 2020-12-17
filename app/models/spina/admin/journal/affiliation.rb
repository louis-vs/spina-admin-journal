# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Links an author with their institutions.
      # An author may have many affiliations as they may vary over time.
      # This record allows author affiliation to be automatically determined,
      # based on the date of the publication.
      #
      # - Validates
      # Presence:: {#start_date}, {#end_date}
      class Affiliation < ApplicationRecord
        # @!attribute [rw] author
        #   @return [ActiveRecord::Relation] the author whose affiliation this record holds
        belongs_to :author
        # @!attribute [rw] insttution
        #   @return [ActiveRecord::Relation] the institution to which the author is affiliated
        belongs_to :institution

        validates :start_date, presence: true
        validates :end_date, presence: true
      end
    end
  end
end
