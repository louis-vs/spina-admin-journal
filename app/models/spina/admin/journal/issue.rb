# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Record for an issue of a journal.
      # Belongs to a particular volume of a journal. Has many articles.
      #
      # - Validates
      # Presence:: {#number}, {#date}
      class Issue < ApplicationRecord
        # @!attribute [rw] number
        #   @return [Integer]
        # @!attribute [rw] title
        #   @return [String]
        # @!attribute [rw] description
        #   @return [String]
        # @!attribute [rw] volume
        #   @return [ActiveRecord::Relation] the volume that contains this issue
        belongs_to :volume
        # @!attribute [rw] cover_img
        #   @return [Spina::Image, nil] the issue's cover image
        belongs_to :cover_img, class_name: 'Spina::Image', optional: true

        # @!attribute [rw] issue
        #   @return [ActiveRecord::Relation] the articles within this issue
        has_many :articles, dependent: :destroy

        validates :number, presence: true
        validates :date, presence: true
      end
    end
  end
end
