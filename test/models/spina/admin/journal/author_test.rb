# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class AuthorTest < ActiveSupport::TestCase
        setup do
          @author = spina_admin_journal_authors :marcus
          @new_author = Author.new
        end

        test 'author has associated author_names' do
          assert_not_nil @author.author_names
          assert @new_author.author_names.empty?
        end
      end
    end
  end
end
