# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class Test < ActiveSupport::TestCase
        test 'version set' do
          assert_kind_of String, VERSION
        end
      end
    end
  end
end
