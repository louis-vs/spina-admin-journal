# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class AuthorsControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          @author = spina_admin_journal_authors :marcus
          @user = spina_users :admin
          post admin_sessions_url, params: { email: @user.email, password: 'password' }
        end

        test 'should get index' do
          skip
          get admin_journal_authors_url
          assert_response :success
        end

        test 'should get new' do
          skip
          get new_admin_journal_author_url
          assert_response :success
        end

        test 'should get edit' do
          skip
          get edit_admin_journal_author_url(@author.id)
          assert_response :success
        end

        test 'should create author' do
          skip
          attributes = @author.attributes
          assert_difference 'Author.count' do
            post admin_journal_authors_url, params: { admin_journal_author: attributes }
          end
          assert_redirected_to admin_journal_authors_url
          assert_equal 'Author saved.', flash[:success]
        end

        test 'should update author' do
          skip
          attributes = @author.attributes
          attributes[:author_name_id] = spina_admin_journal_author_names(:toope).id
          patch admin_journal_author_url(@author), params: { admin_journal_author: attributes }
          assert_redirected_to admin_journal_authors_url
          assert_equal 'Author saved.', flash[:success]
        end
      end
    end
  end
end
