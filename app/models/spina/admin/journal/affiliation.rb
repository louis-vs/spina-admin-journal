# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Links an author with their institutions.
      # An author may have many affiliations as they may vary over time.
      # This record allows author affiliation to be automatically determined,
      # based on the date of the publication.
      class Affiliation < ApplicationRecord
        belongs_to :author
        belongs_to :institution

        validates :start_date, presence: true
        validates :end_date, presence: true
      end
    end
  end
end
