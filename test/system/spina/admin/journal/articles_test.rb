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
          assert_text 'Articles'
        end

        test 'creating an article' do
          visit admin_journal_articles_path
          click_on 'New article'
          assert_text 'New article'
          fill_in 'article_title', with: 'New article'
          select 'Volume 1 Issue 1', from: 'article_issue_id'
          within '.collection-check-boxes' do
            @article.affiliations.each do |affiliation|
              find("label[for=article_affiliation_ids_#{affiliation.id}]").click
            end
          end

          # check that authors list is empty
          click_on 'Authors'
          assert_text 'There are no items'

          click_on 'Save article'
          assert_text 'Article saved'
        end

        test 'updating an article' do
          visit admin_journal_articles_path
          within "li[data-id=\"#{@article.id}\"]" do
            click_on 'Edit'
          end
          assert_text @article.title
          fill_in 'article_title', with: 'Updated article'

          # check that authors list isn't empty
          click_on 'Authors'
          assert_no_text 'There are no items'

          click_on 'Save article'
          assert_text 'Article saved'
        end

        test 'destroying an article' do
          skip 'No idea how to implement this.'
          visit admin_journal_articles_path

          within "li[data-id=\"#{@article.id}\"]" do
            click_on 'Edit'
          end

          within '.relative[data-controller="reveal"]' do
            click_button
          end
          click_on 'Permanently delete'

          find '.modal', visible: true, style: { display: 'block' }
          assert_text "Are you sure you want to delete '#{@article.title}'?"
          click_on 'Delete'

          assert_text 'Article deleted'
        end

        test 'reordering authorships' do
          skip 'Currently broken in CI but works locally - needs investigating'
          visit edit_admin_journal_article_path(@article_with_multiple_authors)

          within 'nav#secondary' do
            click_on 'Authors'
          end

          list = find_all('li[draggable=true]')
          list.last.drag_to list.first, html5: true

          assert_text 'Sorted successfully'
        end
      end
    end
  end
end
