# frozen_string_literal: true

require 'application_system_test_case'

module Spina
  module Admin
    module Journal
      class IssuesTest < ApplicationSystemTestCase
        setup do
          @issue = spina_admin_journal_issues :vol1_issue1
          authenticate
        end

        test 'visiting the index' do
          visit admin_journal_issues_path
          assert_selector '.breadcrumbs' do
            assert_text 'Issues'
          end
        end

        test 'creating an issue' do
          visit admin_journal_issues_path
          click_on 'New issue'
          assert_selector '.breadcrumbs' do
            assert_text 'New issue'
          end
          fill_in 'issue_title', with: 'New issue'
          fill_in 'issue_date', with: Date.today

          # check that articles list is empty
          within 'nav#secondary' do
            click_on 'Articles'
          end
          assert_text 'No Articles'

          click_on 'Save issue'
          assert_text 'Issue saved'
        end

        test 'updating an issue' do
          visit admin_journal_issues_path
          within "tr[data-id=\"#{@issue.id}\"]" do
            click_on 'View'
          end
          within '.breadcrumbs' do
            assert_text "Issue ##{@issue.number}"
          end
          fill_in 'issue_title', with: 'Updated issue'
          fill_in 'issue_date', with: Date.today

          # check that articles list isn't empty
          within 'nav#secondary' do
            click_on 'Articles'
          end
          assert_no_text 'No Articles'

          click_on 'Save issue'
          assert_text 'Issue saved'
        end

        test 'destroying an article' do
          visit admin_journal_issues_path

          within "tr[data-id=\"#{@issue.id}\"]" do
            click_on 'View'
          end

          accept_alert do
            click_on 'Permanently delete'
          end
          # find '#overlay', visible: true, style: { display: 'block' }
          # assert_text "Are you sure you want to delete Issue ##{@issue.number}?"
          # click_on 'Yes, I\'m sure'
          assert_text 'Issue deleted'
        end

        test 'reordering articles' do
          visit edit_admin_journal_issue_path(@issue)

          within 'nav#secondary' do
            click_on 'Articles'
          end

          list = find_all('tr[draggable=true]')
          list.last.drag_to list.first, html5: true

          assert_text 'Sorted successfully'
        end
      end
    end
  end
end
