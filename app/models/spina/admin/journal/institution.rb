# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Simple model for an institution. Associated with authors via affiliations.
      #
      # - Validates
      # Presence:: {#name}
      # Uniqueness:: {#name}
      class Institution < ApplicationRecord
        # @!attribute [rw] name
        #   @return [String]
        # @!attribute [rw] affiliations
        #   @return [ActiveRecord::Relation] the affiliations held at the institution
        has_many :affiliations, dependent: :nullify

        validates :name, presence: true, uniqueness: { case_sensitive: false }
      end
    end
  end
end
