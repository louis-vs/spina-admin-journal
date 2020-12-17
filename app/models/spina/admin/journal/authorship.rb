# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Joins articles and author_names
      # @see Article, AuthorName
      class Authorship < ApplicationRecord
        belongs_to :article
        belongs_to :author_name
      end
    end
  end
end
