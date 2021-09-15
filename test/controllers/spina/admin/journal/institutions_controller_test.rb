# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class InstitutionsControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          @institution = spina_admin_journal_institutions :rockbottom
          @user = spina_users :admin
          post admin_sessions_url, params: { email: @user.email, password: 'password' }
        end

        test 'should get index' do
          get admin_journal_institutions_url
          assert_response :success
        end

        test 'should get new' do
          get new_admin_journal_institution_url
          assert_response :success
        end

        test 'should get edit' do
          get edit_admin_journal_institution_url(@institution.id)
          assert_response :success
        end

        test 'should create institution' do
          attributes = @institution.attributes
          attributes[:name] = 'New Institution'
          assert_difference 'Institution.count' do
            post admin_journal_institutions_url, params: { institution: attributes }
          end
          assert_redirected_to admin_journal_institutions_url
          assert_equal 'Institution saved.', flash[:success]
        end

        test 'should not create invalid institution' do
          attributes = @institution.attributes
          attributes[:name] = nil
          assert_no_difference 'Institution.count' do
            post admin_journal_institutions_url, params: { institution: attributes }
          end
          assert_response :success
          assert_not_equal 'Institution saved.', flash[:success]
        end

        test 'should update institution' do
          attributes = @institution.attributes
          attributes[:name] = 'New name'
          patch admin_journal_institution_url(@institution), params: { institution: attributes }
          assert_redirected_to admin_journal_institutions_url
          assert_equal 'Institution saved.', flash[:success]
        end

        test 'should not update invalid institution' do
          attributes = @institution.attributes
          attributes[:name] = nil
          patch admin_journal_institution_url(@institution), params: { institution: attributes }
          assert_response :success
          assert_not_equal 'Institution saved.', flash[:success]
        end

        test 'should destroy institution' do
          assert_difference 'Institution.count', -1 do
            delete admin_journal_institution_url(@institution)
          end
          assert_redirected_to admin_journal_institutions_url
          assert_equal 'Institution deleted.', flash[:success]
        end
      end
    end
  end
end
