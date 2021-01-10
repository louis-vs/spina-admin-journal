# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class JournalTest < ActiveSupport::TestCase
        setup do
          @journal = spina_admin_journal_journals :journal
          @new_journal = Journal.new
        end

        test 'journal has associated volumes' do
          assert_not_nil @journal.volumes
          assert @new_journal.volumes.empty?
        end

        test 'should destroy dependent volumes when destroyed' do
          assert_difference 'Volume.count', -1 * Volume.where(journal_id: @journal.id).count do
            @journal.destroy
          end
          assert_empty @journal.errors[:base]
        end

        test 'logo may be empty' do
          assert @journal.valid?
          assert_empty @journal.errors[:logo]
          @journal.logo = nil
          assert @journal.valid?
          assert_empty @journal.errors[:logo]
        end
      end
    end
  end
end
