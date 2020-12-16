# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Journal records. The top level of the database hierarchy.
      class Journal < ApplicationRecord
        # @!attribute [rw] logo
        #   @return [Spina::Image, nil] directly associated image
        belongs_to :logo, class_name: 'Spina::Image', optional: true

        # @!attribute [rw] volumes
        #   @return [ActiveRecord::Relation] directly associated volumes
        has_many :volumes, dependent: :destroy

        validates :name, presence: true
      end
    end
  end
end
