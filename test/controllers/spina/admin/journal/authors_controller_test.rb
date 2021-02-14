# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class AuthorsControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          # fixtures
          @author = spina_admin_journal_authors :marcus
          @institutions = spina_admin_journal_institutions :rockbottom, :miami
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
          get edit_admin_journal_author_url(@author)
          assert_response :success
        end

        test 'should create author' do
          attributes = {
            primary_affiliation_index: '0',
            affiliations_attributes: {
              '0': { institution_id: @institutions[0].id, first_name: 'first', surname: 'last' },
              '1': { institution_id: @institutions[1].id, first_name: 'first', surname: 'last' }
            }
          }
          assert_difference -> { Author.count } => 1, -> { Affiliation.count } => 2 do
            post admin_journal_authors_url, params: { admin_journal_author: attributes }
          end
          assert_redirected_to admin_journal_authors_url
          assert_equal 'Author saved.', flash[:success]
        end

        test 'should not create author with no primary affiliation' do
          attributes = {
            affiliations_attributes: {
              '0': { institution_id: 1, first_name: 'first', surname: 'last' },
              '1': { institution_id: 2, first_name: 'first', surname: 'last' }
            }
          }
          assert_no_difference %w[Author.count Affiliation.count] do
            post admin_journal_authors_url, params: { admin_journal_author: attributes }
          end
          assert_response :success
          assert_not_equal 'Author saved.', flash[:success]
        end

        test 'should update author' do
          attributes = @author.attributes
          attributes['affiliations_attributes'] = @author.affiliations.to_a.map.with_index do |affiliation, index|
            [index.to_s, affiliation.attributes]
          end.to_h
          attributes['affiliations_attributes']['0']['first_name'] = 'testing name'
          patch admin_journal_author_url(@author), params: { admin_journal_author: attributes }
          assert_redirected_to admin_journal_authors_url
          assert_equal 'Author saved.', flash[:success]
          assert_equal 1, Affiliation.where(first_name: 'testing name', author_id: @author.id).count
        end

        test 'should update author\'s primary affiliation' do
          attributes = @author.attributes
          attributes['primary_affiliation_index'] = '1'
          attributes['affiliations_attributes'] = @author.affiliations.to_a.map.with_index do |affiliation, index|
            [index.to_s, affiliation.attributes]
          end.to_h
          patch admin_journal_author_url(@author), params: { admin_journal_author: attributes }
          assert_redirected_to admin_journal_authors_url
          assert_equal 'Author saved.', flash[:success]
        end

        test 'should not update author with invalid affiliation attributes' do
          attributes = @author.attributes
          attributes['affiliations_attributes'] = @author.affiliations.to_a.map.with_index do |affiliation, index|
            [index.to_s, affiliation.attributes]
          end.to_h
          attributes['affiliations_attributes']['0']['first_name'] = nil
          patch admin_journal_author_url(@author), params: { admin_journal_author: attributes }
          assert_response :success
          assert_not_equal 'Author saved.', flash[:success]
        end

        test 'should destroy author' do
          assert_difference -> { Author.count } => -1, -> { Affiliation.count } => -1 * @author.affiliations.count do
            delete admin_journal_author_url(@author)
          end
          assert_redirected_to admin_journal_authors_url
          assert_equal 'Author deleted.', flash[:success]
        end
      end
    end
  end
end
