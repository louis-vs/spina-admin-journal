# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # The Author record effectively serves as a join between affiliations
      # and names. In the entropic flux of reality, this serves as a point of
      # constancy.
      class Author < ApplicationRecord
        has_many :author_names, dependent: :restrict_with_error
        has_many :affiliations, dependent: :destroy
      end
    end
  end
end
