# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class AuthorNameTest < ActiveSupport::TestCase
        setup do
          @author_name = spina_admin_journal_author_names :marcus
          @author_name_no_articles = spina_admin_journal_author_names :toope
          @new_author_name = AuthorName.new
        end

        test 'author_name has associated author' do
          assert_not_nil @author_name.author
          assert_nil @new_author_name.author
        end

        test 'author_name has associated articles' do
          assert_not_nil @author_name.articles
          assert @new_author_name.articles.empty?
        end

        test 'should not destroy if there exist dependent authorships' do
          @author_name.destroy
          assert @author_name.persisted?
          assert_not_empty @author_name.errors[:base]
        end

        test 'should destroy if there are no dependent authorships' do
          assert_difference 'Authorship.count', -1 * @author_name_no_articles.authorships.count do
            @author_name_no_articles.destroy
          end
          assert_empty @author_name_no_articles.errors[:base]
        end

        test 'author should not be empty' do
          assert @author_name.valid?
          assert_empty @author_name.errors[:author]
          @author_name.author = nil
          assert @author_name.invalid?
          assert_not_empty @author_name.errors[:author]
        end

        test 'first name should not be empty' do
          assert @author_name.valid?
          assert_empty @author_name.errors[:first_name]
          @author_name.first_name = nil
          assert @author_name.invalid?
          assert_not_empty @author_name.errors[:first_name]
        end

        test 'surname should not be empty' do
          assert @author_name.valid?
          assert_empty @author_name.errors[:surname]
          @author_name.surname = nil
          assert @author_name.invalid?
          assert_not_empty @author_name.errors[:surname]
        end
      end
    end
  end
end
