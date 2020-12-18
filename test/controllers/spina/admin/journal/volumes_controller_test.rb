# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class VolumesControllerTest < ActionDispatch::IntegrationTest
        include Engine.routes.url_helpers

        test 'should get index' do
          get admin_journal_volumes_index_url
          assert_response :success
        end

        test 'should get new' do
          get admin_journal_volumes_new_url
          assert_response :success
        end

        test 'should get edit' do
          get admin_journal_volumes_edit_url
          assert_response :success
        end
      end
    end
  end
end
