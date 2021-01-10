# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class ArticlesControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          @journal = spina_admin_journal_journals :journal
          @article = spina_admin_journal_articles :one
          @user = spina_users :admin
          post admin_sessions_url, params: { email: @user.email, password: 'password' }
        end

        test 'should get index' do
          get admin_journal_articles_url
          assert_response :success
        end

        test 'should get new' do
          get new_admin_journal_article_url
          assert_response :success
        end

        test 'should get edit' do
          get edit_admin_journal_article_url(@article.id)
          assert_response :success
        end
      end
    end
  end
end
