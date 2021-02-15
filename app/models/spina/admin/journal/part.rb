# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Joins partables and pageables.
      #
      # A partable is a model which can be associated with page parts. A pageable is something
      # that can be a page part.
      #
      # === Validators
      # Uniqueness:: name (scope: pageable)
      #
      # @see Journal
      # @see Article
      class Part < ApplicationRecord
        include ::Spina::Part
        include ::Spina::Optionable

        belongs_to :pageable, inverse_of: :parts, polymorphic: true, touch: true
        belongs_to :partable, polymorphic: true, optional: true

        accepts_nested_attributes_for :partable

        validates :name, uniqueness: { scope: :pageable_id }
      end
    end
  end
end
