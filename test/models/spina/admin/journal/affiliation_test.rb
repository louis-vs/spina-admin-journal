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

        test 'affiliation has associated author name' do
          assert_not_nil @affiliation.author_name
          assert_nil @new_affiliation.author_name
        end

        test 'affiliation has associated institution' do
          assert_not_nil @affiliation.institution
          assert_nil @new_affiliation.institution
        end

        test 'author name should not be empty' do
          assert @affiliation.valid?
          assert_empty @affiliation.errors[:author_name]
          @affiliation.author_name = nil
          assert @affiliation.invalid?
          assert_not_empty @affiliation.errors[:author_name]
        end

        test 'institution should not be empty' do
          assert @affiliation.valid?
          assert_empty @affiliation.errors[:institution]
          @affiliation.institution = nil
          assert @affiliation.invalid?
          assert_not_empty @affiliation.errors[:institution]
        end
      end
    end
  end
end
