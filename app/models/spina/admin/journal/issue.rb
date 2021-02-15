# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Record for an issue of a journal.
      # Belongs to a particular volume of a journal. Has many articles.
      #
      # === Validators
      # Presence:: {#number}, {#date}
      # Uniqueness:: {#number} (scope: volume)
      #
      # === Scopes
      # sorted_asc:: sorted in order of increasing number
      # sorted_desc:: sorted highest number first
      #
      # @see Article
      # @see Volume
      class Issue < ApplicationRecord
        include Partable
        # @!attribute [rw] number
        #   @return [Integer] The number
        # @!attribute [rw] title
        #   @return [String] The title of the issue (optional)
        # @!attribute [rw] date
        #   @return [Date] The (planned) publication date of the issue.
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

        validates :number, presence: true, uniqueness: { scope: :volume_id }
        validates :date, presence: true

        scope :sorted_asc, -> { includes(:volume).order('spina_admin_journal_volumes.number ASC', number: :asc) }
        scope :sorted_desc, -> { includes(:volume).order('spina_admin_journal_volumes.number DESC', number: :desc) }
      end
    end
  end
end
