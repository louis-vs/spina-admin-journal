# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class AuthorshipTest < ActiveSupport::TestCase
        setup do
          @authorship = spina_admin_journal_authorships :two
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

        test 'position should not be empty' do
          assert @authorship.valid?
          assert_empty @authorship.errors[:position]
          @authorship.position = nil
          assert @authorship.invalid?
          assert_not_empty @authorship.errors[:position]
        end

        test 'position should be unique per article' do
          assert @authorship.valid?
          assert_empty @authorship.errors[:position]
          @authorship.position = 2
          assert @authorship.invalid?
          assert_not_empty @authorship.errors[:position]
        end
      end
    end
  end
end
