# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class VolumesControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          @journal = spina_admin_journal_journals :journal
          @volume = spina_admin_journal_volumes :one
          @user = spina_users :admin
          post admin_sessions_url, params: { email: @user.email, password: 'password' }
        end

        test 'should get index' do
          get admin_journal_volumes_url
          assert_response :success
        end

        test 'should get new' do
          get new_admin_journal_volume_url
          assert_response :success
        end

        test 'should get edit' do
          get edit_admin_journal_volume_url(@volume.id)
          assert_response :success
        end
      end
    end
  end
end
