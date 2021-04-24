# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Journal records. The top level of the database hierarchy.
      #
      # There should only ever be a single Journal record, which must always be accessed
      # using {Journal.instance}
      #
      # === Validatorss
      # Presence:: {#name}, {#singleton_guard}
      # Uniqueness:: {#name}, {#singleton_guard}
      class Journal < ApplicationRecord
        include AttrJson::Record
        include AttrJson::NestedAttributes
        include Spina::Partable
        include Spina::TranslatedContent
        # @!attribute [rw] name
        #   @return [String] The name of the journal.
        # @!attribute [rw] singleton_guard
        #   @return [Integer] Used to guarantee that a record is unique.
        # @!attribute [rw] logo
        #   @return [Spina::Image, nil] The Spina::Image representing the logo of the journal.
        belongs_to :logo, class_name: 'Spina::Image', optional: true

        # @!attribute [rw] volumes
        #   @return [ActiveRecord::Relation] directly associated volumes
        has_many :volumes, dependent: :destroy

        validates :name, presence: true, uniqueness: true
        validates :singleton_guard, presence: true, uniqueness: true

        # Access the journal record.
        #
        # It is possible that Journal.instance gets called from two threads simultaneously.
        # If this occurs, +Journal.create!+ will throw a validation error, since both records will
        # be assigned the same value for +singleton_guard+. This is handled automatically, guaranteeing
        # that there only ever be a single record.
        def self.instance
          Journal.first || Journal.create!(name: I18n.t('spina.admin.journal.unnamed_journal'), singleton_guard: 0)
        rescue ActiveRecord::RecordNotUnique
          # prevent race conditions leading to multiple records being created
          logger.error 'Error when retrieving Journal instance. Retrying...'
          retry
        end
      end
    end
  end
end
