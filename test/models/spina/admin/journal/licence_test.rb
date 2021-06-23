# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class LicenceTest < ActiveSupport::TestCase
        setup do
          @licence = spina_admin_journal_licences :cc_by
          @new_licence = Licence.new
        end

        test 'licence has associated articles' do
          assert_not_nil @licence.articles
          assert @new_licence.articles.empty?
        end

        test 'destroying licence should nullify reference in articles' do
          article = @licence.articles.first
          assert_not_nil article.licence
          assert_empty article.errors[:licence]
          @licence.destroy
          article.reload
          assert_nil article.licence
          assert_empty article.errors[:licence]
        end

        test 'name should not be empty' do
          assert @licence.valid?
          assert_empty @licence.errors[:name]
          @licence.name = nil
          assert @licence.invalid?
          assert_not_empty @licence.errors[:name]
        end

        test 'abbreviated_name may be empty' do
          assert @licence.valid?
          assert_empty @licence.errors[:abbreviated_name]
          @licence.abbreviated_name = nil
          assert @licence.valid?
          assert_empty @licence.errors[:abbreviated_name]
        end
      end
    end
  end
end
