# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class AffiliationTest < ActiveSupport::TestCase
        setup do
          @affiliation = spina_admin_journal_affiliations :marcus
          @affiliation_no_articles = spina_admin_journal_affiliations :toope
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

        test 'affiliation has associated articles' do
          assert_not_nil @affiliation.articles
          assert @new_affiliation.articles.empty?
        end

        test 'should not destroy if there exist dependent authorships' do
          @affiliation.destroy
          assert @affiliation.persisted?
          assert_not_empty @affiliation.errors[:base]
        end

        test 'should destroy if there are no dependent authorships' do
          assert_difference 'Authorship.count', -1 * @affiliation_no_articles.authorships.count do
            @affiliation_no_articles.destroy
          end
          assert_empty @affiliation_no_articles.errors[:base]
        end

        test 'first name should not be empty' do
          assert @affiliation.valid?
          assert_empty @affiliation.errors[:first_name]
          @affiliation.first_name = nil
          assert @affiliation.invalid?
          assert_not_empty @affiliation.errors[:first_name]
        end

        test 'surname should not be empty' do
          assert @affiliation.valid?
          assert_empty @affiliation.errors[:surname]
          @affiliation.surname = nil
          assert @affiliation.invalid?
          assert_not_empty @affiliation.errors[:surname]
        end

        test 'institution should not be empty' do
          assert @affiliation.valid?
          assert_empty @affiliation.errors[:institution]
          @affiliation.institution = nil
          assert @affiliation.invalid?
          assert_not_empty @affiliation.errors[:institution]
        end

        test 'author should not be empty' do
          assert @affiliation.valid?
          assert_empty @affiliation.errors[:author]
          @affiliation.author = nil
          assert @affiliation.invalid?
          assert_not_empty @affiliation.errors[:author]
        end
      end
    end
  end
end
