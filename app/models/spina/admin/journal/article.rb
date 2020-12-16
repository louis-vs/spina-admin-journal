# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Record for an individual article.
      class Article < ApplicationRecord
        belongs_to :issue
        belongs_to :file, class_name: 'Spina::Attachment', optional: true

        has_many :authorships, dependent: :destroy
        has_many :author_names, through: :authorships

        validates :title, presence: true
        validates :order, presence: true
      end
    end
  end
end
