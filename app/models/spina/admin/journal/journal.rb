# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Journal records. The top level of the database hierarchy.
      class Journal < ApplicationRecord
        include Partable
        # @!attribute [rw] name
        #   @return [String]
        # @!attribute [rw] logo
        #   @return [Spina::Image, nil] directly associated image
        belongs_to :logo, class_name: 'Spina::Image', optional: true

        # @!attribute [rw] volumes
        #   @return [ActiveRecord::Relation] directly associated volumes
        has_many :volumes, dependent: :destroy

        has_many :parts, as: :pageable, dependent: :destroy
        accepts_nested_attributes_for :parts, allow_destroy: true

        validates :name, presence: true
      end
    end
  end
end
