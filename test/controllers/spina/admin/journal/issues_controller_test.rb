# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class IssuesControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          # fixtures
          @issue = spina_admin_journal_issues :vol1_issue1
          @empty_issue = spina_admin_journal_issues :vol1_issue2_empty
          # authenticate
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
            post admin_journal_issues_url, params: { issue: attributes }
          end
          assert_redirected_to admin_journal_issues_url
          assert_equal 'Issue saved.', flash[:success]
        end

        test 'should not create invalid issue' do
          attributes = @issue.attributes
          attributes[:date] = nil
          assert_no_difference 'Issue.count' do
            post admin_journal_issues_url, params: { issue: attributes }
          end
          assert_response :success
          assert_not_equal 'Issue saved.', flash[:success]
        end

        test 'should update issue' do
          attributes = @issue.attributes
          attributes[:title] = 'New name'
          patch admin_journal_issue_url(@issue), params: { issue: attributes }
          assert_redirected_to admin_journal_issues_url
          assert_equal 'Issue saved.', flash[:success]
        end

        test 'should destroy issue' do
          assert_difference 'Issue.count', -1 do
            delete admin_journal_issue_url(@issue)
          end
          assert_redirected_to admin_journal_issues_url
          assert_equal 'Issue deleted.', flash[:success]
        end

        test 'should render form when partable missing' do
          get edit_admin_journal_issue_url(@empty_issue)
        end

        test 'should sort if given valid order' do
          data = { ids: [ @empty_issue.id, @issue.id ] }
          post sort_admin_journal_issues_url(@issue.volume), params: data
          assert_equal 1, Issue.find(@empty_issue.id).number
          assert_equal 2, Issue.find(@issue.id).number
        end
      end
    end
  end
end
