# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class AffiliationTest < ActiveSupport::TestCase
        setup do
          @affiliation = spina_admin_journal_affiliations :one
          @new_affiliation = Affiliation.new
        end

        test 'affiliation has associated author' do
          assert_not_nil @affiliation.author
          assert_nil @new_affiliation.author
        end

        test 'affiliation has associated institution' do
          assert_not_nil @affiliation.institution
          assert_nil @new_affiliation.institution
        end

        test 'author should not be empty' do
          assert @affiliation.valid?
          assert_empty @affiliation.errors[:author]
          @affiliation.author = nil
          assert @affiliation.invalid?
          assert_not_empty @affiliation.errors[:author]
        end

        test 'institution should not be empty' do
          assert @affiliation.valid?
          assert_empty @affiliation.errors[:institution]
          @affiliation.institution = nil
          assert @affiliation.invalid?
          assert_not_empty @affiliation.errors[:institution]
        end

        test 'start_date should not be empty' do
          assert @affiliation.valid?
          assert_empty @affiliation.errors[:start_date]
          @affiliation.start_date = nil
          assert @affiliation.invalid?
          assert_not_empty @affiliation.errors[:start_date]
        end

        test 'end_date should not be empty' do
          assert @affiliation.valid?
          assert_empty @affiliation.errors[:end_date]
          @affiliation.end_date = nil
          assert @affiliation.invalid?
          assert_not_empty @affiliation.errors[:end_date]
        end
      end
    end
  end
end
