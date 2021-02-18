# frozen_string_literal: true

require 'application_system_test_case'

module Spina
  module Admin
    module Journal
      class ArticlesTest < ApplicationSystemTestCase
        setup do
          @article = spina_admin_journal_articles :new_wave
          authenticate
        end

        test 'visiting the index' do
          visit admin_journal_articles_path
          assert_selector '.breadcrumbs' do
            assert_text 'Articles'
          end
        end

        test 'creating an article' do
          visit admin_journal_articles_path
          click_on 'New article'
          assert_selector '.breadcrumbs' do
            assert_text 'New article'
          end
          fill_in 'admin_journal_article_title', with: 'New article'
          select 'Volume 1 Issue 1', from: 'admin_journal_article_issue_id'
          select 'Marcus Atherton', from: 'admin_journal_article_affiliation_ids'

          # check that authors list is empty
          within 'nav#secondary' do
            click_on 'Authors'
          end
          assert_text 'There are no authors'

          click_on 'Save article'
          assert_text 'Article saved'
        end

        test 'updating an article' do
          visit admin_journal_articles_path
          within "tr[data-id=\"#{@article.id}\"]" do
            click_on 'View'
          end
          within '.breadcrumbs' do
            assert_text @article.title
          end
          fill_in 'admin_journal_article_title', with: 'Updated article'

          # check that authors list isn't empty
          within 'nav#secondary' do
            click_on 'Authors'
          end
          assert_no_text 'There are no authors'

          click_on 'Save article'
          assert_text 'Article saved'
        end

        test 'destroying an article' do
          visit admin_journal_articles_path

          within "tr[data-id=\"#{@article.id}\"]" do
            click_on 'View'
          end

          click_on 'Permanently delete'
          find '#overlay', visible: true, style: { display: 'block' }
          assert_text "Are you sure you want to delete '#{@article.title}'?"
          click_on 'Yes, I\'m sure'
          assert_text 'Article deleted'
        end
      end
    end
  end
end