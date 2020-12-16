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

        test 'order should not be empty' do
          assert @article.valid?
          assert_empty @article.errors[:order]
          @article.order = nil
          assert @article.invalid?
          assert_not_empty @article.errors[:order]
        end

        test 'title should not be empty' do
          assert @article.valid?
          assert_empty @article.errors[:title]
          @article.title = nil
          assert @article.invalid?
          assert_not_empty @article.errors[:title]
        end

        test 'abstract may be empty' do
          assert @article.valid?
          assert_empty @article.errors[:abstract]
          @article.abstract = nil
          assert @article.valid?
          assert_empty @article.errors[:abstract]
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
