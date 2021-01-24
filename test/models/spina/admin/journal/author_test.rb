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

        test 'author has associated affiliations' do
          assert_not_nil @author.affiliations
          assert @new_author.affiliations.empty?
        end
      end
    end
  end
end
