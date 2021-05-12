# frozen_string_literal: true

require 'application_system_test_case'

module Spina
  module Admin
    module Journal
      class ArticlesTest < ApplicationSystemTestCase
        setup do
          @article = spina_admin_journal_articles :new_wave
          @article_with_multiple_authors = spina_admin_journal_articles :article_two
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
          within '.collection-check-boxes' do
            @article.affiliations.each do |affiliation|
              find("label[for=admin_journal_article_affiliation_ids_#{affiliation.id}]").click
            end
          end

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

          accept_alert do
            click_on 'Permanently delete'
          end
          # find '#overlay', visible: true, style: { display: 'block' }
          # assert_text "Are you sure you want to delete '#{@article.title}'?"
          # click_on 'Yes, I\'m sure'
          assert_text 'Article deleted'
        end

        test 'reordering authorships' do
          visit edit_admin_journal_article_path(@article_with_multiple_authors)

          within 'nav#secondary' do
            click_on 'Authors'
          end

          list = find_all('tr[draggable=true]')
          list.last.drag_to list.first, html5: true

          assert_text 'Sorted successfully'
        end
      end
    end
  end
end
