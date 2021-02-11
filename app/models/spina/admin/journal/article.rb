# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Record for an individual article.
      #
      # - Validators
      # Presence:: {#number}, {#title}
      # URI:: {#url}
      class Article < ApplicationRecord
        include Partable
        # @!attribute [rw] number
        #   @return [Integer]
        # @!attribute [rw] title
        #   @return [String]
        # @!attribute [rw] url
        #   @return [String]
        # @!attribute [rw] doi
        #   @return [String]
        # @!attribute [rw] issue
        #   @return [ActiveRecord::Relation] the issue that contains this article
        belongs_to :issue
        # @!attribute [rw] file
        #   @return [Spina::Attachment] the attached file
        belongs_to :file, class_name: 'Spina::Attachment', optional: true

        # @!attribute [rw] authorships
        has_many :authorships, dependent: :destroy
        # @!attribute [rw] affiliations
        #   @return [ActiveRecord::Relation] the authors of the article
        has_many :affiliations, through: :authorships

        # @!attribute [rw] parts
        #   @return [ActiveRecord::Relation] page parts, see {ArticlesController}
        has_many :parts, as: :pageable, dependent: :destroy
        accepts_nested_attributes_for :parts, allow_destroy: true

        validates :number, presence: true
        validates :title, presence: true
        validates :url, 'spina/admin/journal/uri': true

        scope :sorted_asc, -> { includes(:issue).order('spina_admin_journal_issues.number ASC', number: :asc) }
        scope :sorted_desc, -> { includes(:issue).order('spina_admin_journal_issues.number DESC', number: :desc) }
      end
    end
  end
end
