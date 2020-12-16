# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Record for the names of authors (since authors can plausibly have multiple,
      # e.g. variants). This is the record that is associated with Articles themselves.
      class AuthorName < ApplicationRecord
        belongs_to :author
        has_many :authorships, dependent: :destroy
        has_many :articles, through: :authorships
      end
    end
  end
end
