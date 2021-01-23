# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class IssuesControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          @journal = spina_admin_journal_journals :journal
          @issue = spina_admin_journal_issues :one
          @user = spina_users :admin
          post admin_sessions_url, params: { email: @user.email, password: 'password' }
        end

        test 'should get index' do
          get admin_journal_issues_url
          assert_response :success
        end

        test 'should get new' do
          get new_admin_journal_issue_url
          assert_response :success
        end

        test 'should get edit' do
          get edit_admin_journal_issue_url(@issue.id)
          assert_response :success
        end

        test 'should create issue' do
          attributes = @issue.attributes
          attributes[:title] = 'New Issue'
          assert_difference 'Issue.count' do
            post admin_journal_issues_url, params: { admin_journal_issue: attributes }
          end
          assert_redirected_to admin_journal_issues_url
          assert_equal 'Issue saved.', flash[:success]
        end

        test 'should not create invalid issue' do
          attributes = @issue.attributes
          attributes[:date] = nil
          assert_no_difference 'Issue.count' do
            post admin_journal_issues_url, params: { admin_journal_issue: attributes }
          end
          assert_response :success
          assert_not_equal 'Issue saved.', flash[:success]
        end

        test 'should update issue' do
          attributes = @issue.attributes
          attributes[:title] = 'New name'
          patch admin_journal_issue_url(@issue), params: { admin_journal_issue: attributes }
          assert_redirected_to admin_journal_issues_url
          assert_equal 'Issue saved.', flash[:success]
        end

        test 'should not update invalid issue' do
          attributes = @issue.attributes
          attributes[:date] = nil
          patch admin_journal_issue_url(@issue), params: { admin_journal_issue: attributes }
          assert_response :success
          assert_not_equal 'Issue saved.', flash[:success]
        end

        test 'should destroy issue' do
          assert_difference 'Issue.count', -1 do
            delete admin_journal_issue_url(@issue)
          end
          assert_redirected_to admin_journal_issues_url
          assert_equal 'Issue deleted.', flash[:success]
        end
      end
    end
  end
end
