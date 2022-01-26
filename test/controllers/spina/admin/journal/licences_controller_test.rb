# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class LicencesControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          @licence = spina_admin_journal_licences :cc_by
          @licence_without_parts = spina_admin_journal_licences :gplv3

          @user = spina_users :admin
          post admin_sessions_url, params: { email: @user.email, password: 'password' }
        end

        test 'should get index' do
          get admin_journal_licences_url
          assert_response :success
        end

        test 'should get new' do
          get new_admin_journal_licence_url
          assert_response :success
        end

        test 'should get edit' do
          get edit_admin_journal_licence_url(@licence)
          assert_response :success
        end

        test 'should create licence' do
          attributes = {}
          attributes[:name] = 'New licence'
          attributes[:abbreviated_name] = 'NL'
          assert_difference 'Licence.count' do
            post admin_journal_licences_url, params: { licence: attributes }
          end
          assert_redirected_to %r{licences/\d+/edit}
          assert_equal 'Licence saved.', flash[:success]
        end

        test 'should not create invalid licence' do
          attributes = @licence.attributes
          attributes[:name] = nil
          assert_no_difference 'Licence.count' do
            post admin_journal_licences_url, params: { licence: attributes }
          end
          assert_response :unprocessable_entity
          assert_not_equal 'Licence saved.', flash[:success]
        end

        test 'should update licence' do
          attributes = @licence.attributes
          attributes[:name] = 'Brand new name'
          patch admin_journal_licence_url(@licence), params: { licence: attributes }
          assert_redirected_to edit_admin_journal_licence_url(@licence)
          assert_equal 'Licence saved.', flash[:success]
        end

        test 'should not update invalid licence' do
          attributes = @licence.attributes
          attributes[:name] = nil
          patch admin_journal_licence_url(@licence), params: { licence: attributes }
          assert_response :unprocessable_entity
          assert_not_equal 'Licence saved.', flash[:success]
        end

        test 'should destroy licence' do
          assert_difference 'Licence.count', -1 do
            delete admin_journal_licence_url(@licence)
          end
          assert_redirected_to admin_journal_licences_url
          assert_equal 'Licence deleted.', flash[:success]
        end

        test 'should render form when partables missing' do
          get edit_admin_journal_licence_url(@licence_without_parts)
          assert_response :success
        end
      end
    end
  end
end
