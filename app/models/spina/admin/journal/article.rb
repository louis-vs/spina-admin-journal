# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Record for an individual article.
      #
      # === Validators
      # Presence:: {#number}, {#title}
      # Uniqueness:: {#number} (scope: issue) {status}
      # URI:: {#url}
      #
      # === Scopes
      # sorted_asc:: sorted in order of increasing number
      # sorted_desc:: sorted highest number first
      # visible:: articles that should be visible to the public
      #
      # @see Issue
      # @see Author
      # @see Authorship
      class Article < ApplicationRecord
        include AttrJson::Record
        include AttrJson::NestedAttributes
        include Spina::Partable
        include Spina::TranslatedContent
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

        # @!attribute [rw] authorships
        has_many :authorships, dependent: :destroy
        # @!attribute [rw] affiliations
        #   @return [ActiveRecord::Relation] The authors of the article.
        has_many :affiliations, through: :authorships

        # @!attribute [rw] status
        #   @return [Integer] the current status of the article
        enum status: { published: 0, draft: 1, meta: 2 }

        validates :number, presence: true, uniqueness: { scope: :issue_id }
        validates :title, presence: true
        validates :url, 'spina/admin/journal/uri': true
        validates :status, presence: true

        scope :visible, -> { where(status: %i[published meta]) }
        scope :sorted_asc, -> { includes(:issue).order('spina_admin_journal_issues.number ASC', number: :asc) }
        scope :sorted_desc, -> { includes(:issue).order('spina_admin_journal_issues.number DESC', number: :desc) }

        # Returns true if the article should be visible to end users (i.e. is not a draft).
        def visible?
          published? || meta?
        end
      end
    end
  end
end
