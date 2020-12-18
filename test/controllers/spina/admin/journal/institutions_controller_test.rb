# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class InstitutionsControllerTest < ActionDispatch::IntegrationTest
        include Engine.routes.url_helpers

        test 'should get index' do
          get admin_journal_institutions_index_url
          assert_response :success
        end

        test 'should get new' do
          get admin_journal_institutions_new_url
          assert_response :success
        end

        test 'should get edit' do
          get admin_journal_institutions_edit_url
          assert_response :success
        end
      end
    end
  end
end
