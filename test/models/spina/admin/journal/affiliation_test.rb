# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class AffiliationTest < ActiveSupport::TestCase
        setup do
          @affiliation = spina_admin_journal_affiliations :marcus
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

        test 'should destroy if there exist dependent authorships' do
          assert_difference 'Affiliation.count', -1 do
            @affiliation.destroy
          end
          assert_empty @affiliation.errors[:base]
        end

        test 'should destroy dependent authorships' do
          assert_difference 'Authorship.count', -1 * @affiliation.authorships.count do
            @affiliation.destroy
          end
          assert_empty @affiliation.errors[:base]
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
