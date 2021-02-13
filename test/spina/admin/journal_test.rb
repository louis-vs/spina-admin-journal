# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class Test < ActiveSupport::TestCase
        test 'version set' do
          assert_kind_of String, VERSION
        end

        test 'table name prefix set' do
          assert_equal 'spina_admin_journal_', ::Spina::Admin::Journal.table_name_prefix
        end
      end
    end
  end
end
