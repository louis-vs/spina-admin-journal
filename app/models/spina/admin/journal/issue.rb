# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Record for an issue of a journal.
      # Belongs to a particular volume of a journal. Has many articles.
      class Issue < ApplicationRecord
        belongs_to :volume
        belongs_to :cover_img, class_name: 'Spina::Image', optional: true

        has_many :articles, dependent: :destroy

        validates :number, presence: true
        validates :date, presence: true
      end
    end
  end
end
