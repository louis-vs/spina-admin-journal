# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class AuthorNameTest < ActiveSupport::TestCase
        setup do
          @author_name = spina_admin_journal_author_names :marcus
          @new_author_name = AuthorName.new
        end

        test 'author_name has associated author' do
          assert_not_nil @author_name.author
          assert_nil @new_author_name.author
        end

        test 'author_name has associated articles' do
          assert_not_nil @author_name.articles
          assert @new_author_name.articles.empty?
        end
      end
    end
  end
end
