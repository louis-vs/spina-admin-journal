# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class ArticleTest < ActiveSupport::TestCase
        setup do
          @article = spina_admin_journal_articles :new_wave
          @new_article = Article.new
        end

        test 'article has associated affiliations' do
          assert_not_nil @article.affiliations
          assert @new_article.affiliations.empty?
        end

        test 'article has associated issue' do
          assert_not_nil @article.issue
          assert_nil @new_article.issue
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

        test 'number should be unique per issue' do
          assert @article.valid?
          assert_empty @article.errors[:number]
          @article.number = 2
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
      end
    end
  end
end
