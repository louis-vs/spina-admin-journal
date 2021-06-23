# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # A record to hold information about copyright licences.
      #
      # Associated with individual articles.
      #
      # === Validators
      # Presence:: {#name}
      class Licence < ApplicationRecord
        include AttrJson::Record
        include AttrJson::NestedAttributes
        include Spina::Partable
        include Spina::TranslatedContent

        # @!attribute [rw] name
        #   @return [String] the name of the licence
        # @!attribute [rw] abbreviated_name
        #   @return [String] an optional abbreviated form of the licence name
        # @!attribute [rw] articles
        #   @return [ActiveRecord::Relation] articles which use this licence
        has_many :articles, dependent: :nullify

        validates :name, presence: true

        scope :sorted, -> { order(name: :asc) }
      end
    end
  end
end
