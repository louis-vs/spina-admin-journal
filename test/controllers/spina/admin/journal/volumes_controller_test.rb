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
          # authenticate
          @user = spina_users :admin
          post admin_sessions_url, params: { email: @user.email, password: 'password' }
        end

        test 'should get edit' do
          get edit_admin_journal_volume_url(@volume)
          assert_response :success
        end

        test 'should create volume' do
          attributes = @volume.attributes
          attributes[:number] = 24
          assert_difference 'Volume.count' do
            post admin_journal_volumes_url, params: { admin_journal_volume: attributes }
          end
          assert_redirected_to admin_journal_volumes_url
          assert_equal 'Volume <strong>3</strong> created.', flash[:success]
        end

        test 'should destroy volume' do
          assert_difference 'Volume.count', -1 do
            delete admin_journal_volume_url(@volume)
          end
          assert_redirected_to admin_journal_volumes_url
          assert_equal 'Volume deleted.', flash[:success]
        end
      end
    end
  end
end
