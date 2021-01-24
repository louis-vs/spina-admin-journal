# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class ArticleTest < ActiveSupport::TestCase
        setup do
          @article = spina_admin_journal_articles :one
          @new_article = Article.new
        end

        test 'article has associated author_names' do
          assert_not_nil @article.author_names
          assert @new_article.author_names.empty?
        end

        test 'article has associated issue' do
          assert_not_nil @article.issue
          assert_nil @new_article.issue
        end

        test 'article has associated file' do
          assert_not_nil @article.file
          assert_nil @new_article.file
        end

        test 'should destroy dependent authorships when destroyed' do
          assert_difference 'Authorship.count', -1 * @article.authorships.count do
            @article.destroy
          end
          assert_empty @article.errors[:base]
        end

        test 'number should not be empty' do
          assert @article.valid?
          assert_empty @article.errors[:number]
          @article.number = nil
          assert @article.invalid?
          assert_not_empty @article.errors[:number]
        end

        test 'title should not be empty' do
          assert @article.valid?
          assert_empty @article.errors[:title]
          @article.title = nil
          assert @article.invalid?
          assert_not_empty @article.errors[:title]
        end

        test 'url may be empty' do
          assert @article.valid?
          assert_empty @article.errors[:url]
          @article.url = nil
          assert @article.valid?
          assert_empty @article.errors[:url]
        end

        test 'doi may be empty' do
          assert @article.valid?
          assert_empty @article.errors[:doi]
          @article.doi = nil
          assert @article.valid?
          assert_empty @article.errors[:doi]
        end

        test 'file may be empty' do
          assert @article.valid?
          assert_empty @article.errors[:file]
          @article.file = nil
          assert @article.valid?
          assert_empty @article.errors[:file]
        end
      end
    end
  end
end
