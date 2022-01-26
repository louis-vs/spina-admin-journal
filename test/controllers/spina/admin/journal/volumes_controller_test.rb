# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class VolumesControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          # fixtures
          @volume = spina_admin_journal_volumes :vol1
          @volume2 = spina_admin_journal_volumes :vol2
          # authenticate
          @user = spina_users :admin
          post admin_sessions_url, params: { email: @user.email, password: 'password' }
        end

        test 'should get index' do
          get admin_journal_volumes_url
          assert_response :success
        end

        test 'should get edit' do
          get edit_admin_journal_volume_url(@volume)
          assert_response :success
        end

        test 'should create volume' do
          assert_difference 'Volume.count' do
            post admin_journal_volumes_url
          end
          assert_redirected_to admin_journal_volumes_url
          assert_equal 'Volume <strong>4</strong> created.', flash[:success]
        end

        test 'should destroy volume' do
          assert_difference 'Volume.count', -1 do
            delete admin_journal_volume_url(@volume)
          end
          assert_redirected_to admin_journal_volumes_url
          assert_equal 'Volume deleted.', flash[:success]
        end

        test 'should sort if given valid order' do
          data = { ids: [ @volume2.id, @volume.id ] }
          post sort_admin_journal_volumes_url(@volume.journal), params: data
          assert_equal 1, Volume.find(@volume2.id).number
          assert_equal 2, Volume.find(@volume.id).number
        end
      end
    end
  end
end
