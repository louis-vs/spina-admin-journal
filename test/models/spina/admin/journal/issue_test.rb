# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class IssueTest < ActiveSupport::TestCase
        setup do
          @issue = spina_admin_journal_issues :vol1_issue1
          @new_issue = Issue.new
        end

        test 'issue has associated articles' do
          assert_not_nil @issue.articles
          assert @new_issue.articles.empty?
        end

        test 'issue has associated volume' do
          assert_not_nil @issue.volume
          assert_nil @new_issue.volume
        end

        test 'should destroy dependent articles when destroyed' do
          assert_difference 'Article.count', -1 * @issue.articles.count do
            @issue.destroy
          end
          assert_empty @issue.errors[:base]
        end

        test 'number should not be empty' do
          assert @issue.valid?
          assert_empty @issue.errors[:number]
          @issue.number = nil
          assert @issue.invalid?
          assert_not_empty @issue.errors[:number]
        end

        test 'number should be unique per volume' do
          assert @issue.valid?
          assert_empty @issue.errors[:number]
          @issue.number = 2
          assert @issue.invalid?
          assert_not_empty @issue.errors[:number]
        end

        test 'date should not be empty' do
          assert @issue.valid?
          assert_empty @issue.errors[:date]
          @issue.date = nil
          assert @issue.invalid?
          assert_not_empty @issue.errors[:date]
        end

        test 'title may be empty' do
          assert @issue.valid?
          assert_empty @issue.errors[:title]
          @issue.title = nil
          assert @issue.valid?
          assert_empty @issue.errors[:title]
        end
      end
    end
  end
end
