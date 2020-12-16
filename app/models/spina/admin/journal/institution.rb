# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Simple model for an institution. Associated with authors via affiliations.
      class Institution < ApplicationRecord
        has_many :affiliations, dependent: :nullify

        validates :name, presence: true, uniqueness: { case_sensitive: false }
      end
    end
  end
end
