# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class AuthorshipTest < ActiveSupport::TestCase
        setup do
          @authorship = spina_admin_journal_authorships :one
          @new_authorship = Authorship.new
        end

        test 'authorship has associated author_name' do
          assert_not_nil @authorship.author_name
          assert_nil @new_authorship.author_name
        end

        test 'authorship has associated article' do
          assert_not_nil @authorship.article
          assert_nil @new_authorship.article
        end
      end
    end
  end
end
