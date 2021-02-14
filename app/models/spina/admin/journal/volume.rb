# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Volumes of a journal.
      # A journal has multiple volumes, a volume can have multiple issues.
      class Volume < ApplicationRecord
        # @!attribute [rw] number
        #   @return [Integer]
        # @!attribute [rw] journal
        #   @return [ActiveRecord::Relation] the journal that contains this volume
        belongs_to :journal

        # @!attribute [rw] journal
        #   @return [ActiveRecord::Relation] the issues that comprise this volume
        has_many :issues, dependent: :destroy

        validates :number, presence: true, uniqueness: { scope: :journal_id }

        scope :sorted_asc, -> { order(number: :asc) }
        scope :sorted_desc, -> { order(number: :desc) }
      end
    end
  end
end
