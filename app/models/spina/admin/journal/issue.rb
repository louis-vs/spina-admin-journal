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
        include Partable
        # @!attribute [rw] number
        #   @return [Integer]
        # @!attribute [rw] title
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

        # @!attribute [rw] parts
        #   @return [ActiveRecord::Relation] page parts, see {ArticlesController}
        has_many :parts, as: :pageable, dependent: :destroy
        accepts_nested_attributes_for :parts, allow_destroy: true

        validates :number, presence: true
        validates :date, presence: true

        scope :sorted_asc, -> { includes(:volume).order('spina_admin_journal_volumes.number ASC', number: :asc) }
        scope :sorted_desc, -> { includes(:volume).order('spina_admin_journal_volumes.number DESC', number: :desc) }
      end
    end
  end
end
