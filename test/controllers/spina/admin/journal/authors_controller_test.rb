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
          get admin_journal_authors_url
          assert_response :success
        end

        test 'should get new' do
          get new_admin_journal_author_url
          assert_response :success
        end

        test 'should get edit' do
          get edit_admin_journal_author_url(@author.id)
          assert_response :success
        end
      end
    end
  end
end
