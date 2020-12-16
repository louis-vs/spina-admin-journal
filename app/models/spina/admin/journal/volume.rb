# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Volumes of a journal.
      # A journal has multiple volumes, a volume can have multiple issues.
      class Volume < ApplicationRecord
        belongs_to :journal

        has_many :issues, dependent: :destroy
      end
    end
  end
end
