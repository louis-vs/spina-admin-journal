# frozen_string_literal: true

require 'test_helper'

module Spina
  module Parts
    module Admin
      module Journal
        class PageRangeTest < ActiveSupport::TestCase
          setup do
            @new_page_range = PageRange.new
          end

          test 'should save valid page range' do
            @new_page_range.first_page = 1
            @new_page_range.last_page = 2
            assert @new_page_range.valid?
          end

          test 'should save empty page range' do
            assert @new_page_range.valid?
          end

          test 'should not save page range with empty last page' do
            assert @new_page_range.valid?
            @new_page_range.first_page = 1
            assert @new_page_range.invalid?
          end

          test 'should not save page range with smaller last page' do
            assert @new_page_range.valid?
            @new_page_range.first_page = 2
            @new_page_range.last_page = 1
            assert @new_page_range.invalid?
          end
        end
      end
    end
  end
end
