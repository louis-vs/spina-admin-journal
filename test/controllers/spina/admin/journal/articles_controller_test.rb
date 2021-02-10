# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class ArticlesControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          # fixtures
          @article = spina_admin_journal_articles :new_wave
          @empty_article = spina_admin_journal_articles :empty_article
          # authenticate
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

        test 'should create article' do
          attributes = {}
          attributes[:title] = 'New Article'
          attributes[:number] = 3
          attributes[:issue_id] = @article.issue_id
          assert_difference 'Article.count' do
            post admin_journal_articles_url, params: { admin_journal_article: attributes }
          end
          assert_redirected_to admin_journal_articles_url
          assert_equal 'Article saved.', flash[:success]
        end

        test 'should not create invalid article' do
          attributes = @article.attributes
          attributes[:title] = nil
          assert_no_difference 'Article.count' do
            post admin_journal_articles_url, params: { admin_journal_article: attributes }
          end
          assert_response :success
          assert_not_equal 'Article saved.', flash[:success]
        end

        test 'should update article' do
          attributes = @article.attributes
          attributes[:title] = 'New name'
          patch admin_journal_article_url(@article), params: { admin_journal_article: attributes }
          assert_redirected_to admin_journal_articles_url
          assert_equal 'Article saved.', flash[:success]
        end

        test 'should not update invalid article' do
          attributes = @article.attributes
          attributes[:title] = nil
          patch admin_journal_article_url(@article), params: { admin_journal_article: attributes }
          assert_response :success
          assert_not_equal 'Article saved.', flash[:success]
        end

        test 'should destroy article' do
          assert_difference 'Article.count', -1 do
            delete admin_journal_article_url(@article)
          end
          assert_redirected_to admin_journal_articles_url
          assert_equal 'Article deleted.', flash[:success]
        end

        test 'should render form when partable missing' do
          get edit_admin_journal_article_url(@empty_article)
        end
      end
    end
  end
end
