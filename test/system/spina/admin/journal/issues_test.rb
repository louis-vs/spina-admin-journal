# frozen_string_literal: true

require 'application_system_test_case'

module Spina
  module Admin
    module Journal
      class IssuesTest < ApplicationSystemTestCase
        setup do
          @issue = spina_admin_journal_issues :vol1_issue1
          @issue2 = spina_admin_journal_issues :vol1_issue2_empty
          authenticate
        end

        test 'visiting the index' do
          visit admin_journal_issues_path
          assert_text 'Issues'
        end

        test 'creating an issue' do
          visit admin_journal_issues_path
          click_on 'New issue'
          assert_text 'New issue'
          fill_in 'issue_title', with: 'New issue'
          fill_in 'issue_date', with: Time.zone.today

          # check that articles list is empty
          click_button 'Articles', class: 'bg-transparent'
          within '#articles' do
            assert_no_text
          end

          click_on 'Save issue'
          assert_text 'Issue saved'
        end

        test 'updating an issue' do
          visit admin_journal_issues_path
          within "li[data-id=\"#{@issue.id}\"]" do
            click_on 'Edit'
          end
          assert_text "Issue ##{@issue.number}"
          fill_in 'issue_title', with: 'Updated issue'
          fill_in 'issue_date', with: Time.zone.today

          # check that articles list isn't empty
          click_button 'Articles'
          assert_no_text 'There are no items.'

          click_on 'Save issue'
          assert_text 'Issue saved'
        end

        test 'destroying an article' do
          skip 'I have no idea how to do this'
          visit admin_journal_issues_path

          within "li[data-id=\"#{@issue.id}\"]" do
            click_on 'Edit'
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
          visit admin_journal_issues_path
          within "li[data-id=\"#{@issue.id}\"]" do
            click_on 'Edit'
          end
          assert_text "Issue ##{@issue.number}"
          # including these to delay a bit
          fill_in 'issue_title', with: 'Updated issue'
          fill_in 'issue_date', with: Time.zone.today

          click_button 'Articles', class: 'bg-transparent'

          # first_handle = find("li[data-id=\"#{@issue.id}\"] .cursor-move")
          # last_handle = find("li[data-id=\"#{@issue2.id}\"] .cursor-move")
          # first_handle.drag_to last_handle
          list = find_all('.cursor-move')
          list.last.drag_to list.first

          assert_text 'Sorting saved'
        end
      end
    end
  end
end
