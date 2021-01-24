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

        test 'authorship has associated affiliation' do
          assert_not_nil @authorship.affiliation
          assert_nil @new_authorship.affiliation
        end

        test 'authorship has associated article' do
          assert_not_nil @authorship.article
          assert_nil @new_authorship.article
        end
      end
    end
  end
end
