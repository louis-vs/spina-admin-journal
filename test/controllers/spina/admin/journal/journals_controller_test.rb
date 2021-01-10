# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class JournalsControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          @journal = spina_admin_journal_journals :journal
          @user = spina_users :admin
          post admin_sessions_url, params: { email: @user.email, password: 'password' }
        end

        test 'should get edit' do
          get edit_admin_journal_journal_url(@journal.id)
          assert_response :success
        end
      end
    end
  end
end
