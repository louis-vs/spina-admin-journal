# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Record for an individual article.
      #
      # - Validators
      # Presence:: {#order}, {#title}
      class Article < ApplicationRecord
        # @!attribute [rw] order
        #   @return [Integer]
        # @!attribute [rw] title
        #   @return [String]
        # @!attribute [rw] url
        #   @return [String]
        # @!attribute [rw] doi
        #   @return [String]
        # @!attribute [rw] abstract
        #   @return [String]
        # @!attribute [rw] issue
        #   @return [ActiveRecord::Relation] the issue that contains this article
        belongs_to :issue
        # @!attribute [rw] file
        #   @return [Spina::Attachment] the attached file
        belongs_to :file, class_name: 'Spina::Attachment', optional: true

        # @!attribute [rw] authorships
        has_many :authorships, dependent: :destroy
        # @!attribute [rw] author_names
        #   @return [ActiveRecord::Relation] the authors of the article
        has_many :author_names, through: :authorships

        validates :order, presence: true
        validates :title, presence: true
      end
    end
  end
end
