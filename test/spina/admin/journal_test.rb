# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class Test < ActiveSupport::TestCase
        test 'truth' do
          assert_kind_of Module, Spina::Admin::Journal
        end
      end
    end
  end
end
