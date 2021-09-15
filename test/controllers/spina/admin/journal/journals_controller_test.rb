# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class JournalsControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          # fixtures
          @journal = spina_admin_journal_journals :journal
          # authenticates
          @user = spina_users :admin
          post admin_sessions_url, params: { email: @user.email, password: 'password' }
        end

        test 'should get edit' do
          get edit_admin_journal_journal_url(@journal.id)
          assert_response :success
        end

        test 'should update journal' do
          attributes = @journal.attributes
          attributes[:name] = 'New name'
          patch admin_journal_journal_url(@journal), params: { journal: attributes }
          assert_redirected_to edit_admin_journal_journal_url(@journal)
          assert_equal 'Journal saved.', flash[:success]
        end

        test 'should not update invalid journal' do
          attributes = @journal.attributes
          attributes[:name] = nil
          patch admin_journal_journal_url(@journal), params: { journal: attributes }
          assert_response :success
          assert_not_equal 'Journal saved.', flash[:success]
        end

        test 'should destroy journal' do
          delete admin_journal_journal_url(@journal)
          assert_not Journal.exists?(@journal.id)
          assert_redirected_to edit_admin_journal_journal_url(Journal.instance)
          assert_equal 'Journal deleted.', flash[:success]
        end
      end
    end
  end
end
