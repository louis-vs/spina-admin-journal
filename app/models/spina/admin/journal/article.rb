# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Record for an individual article.
      #
      # === Validators
      # Presence:: {#number}, {#title}
      # Uniqueness:: {#number} (scope: issue)
      # URI:: {#url}
      #
      # === Scopes
      # sorted_asc:: sorted in order of increasing number
      # sorted_desc:: sorted highest number first
      #
      # @see Issue
      # @see Author
      # @see Authorship
      class Article < ApplicationRecord
        include Partable
        # @!attribute [rw] number
        #   @return [Integer] The position of the article within its issue.
        # @!attribute [rw] title
        #   @return [String] The article's title.
        # @!attribute [rw] url
        #   @return [String] An external link to the article.
        # @!attribute [rw] doi
        #   @return [String] A digital object intentifier for the article.
        # @!attribute [rw] issue
        #   @return [Issue] The issue that contains this article.
        belongs_to :issue
        # @!attribute [rw] file
        #   @return [Spina::Attachment] The attached file
        belongs_to :file, class_name: 'Spina::Attachment', optional: true

        # @!attribute [rw] authorships
        has_many :authorships, dependent: :destroy
        # @!attribute [rw] affiliations
        #   @return [ActiveRecord::Relation] The authors of the article.
        has_many :affiliations, through: :authorships

        # @!attribute [rw] parts
        #   @return [ActiveRecord::Relation] The page parts associated with this record.
        #   @see ArticlesController
        has_many :parts, as: :pageable, dependent: :destroy
        accepts_nested_attributes_for :parts, allow_destroy: true

        validates :number, presence: true, uniqueness: { scope: :issue_id }
        validates :title, presence: true
        validates :url, 'spina/admin/journal/uri': true

        scope :sorted_asc, -> { includes(:issue).order('spina_admin_journal_issues.number ASC', number: :asc) }
        scope :sorted_desc, -> { includes(:issue).order('spina_admin_journal_issues.number DESC', number: :desc) }
      end
    end
  end
end
