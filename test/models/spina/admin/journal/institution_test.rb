# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class InstitutionTest < ActiveSupport::TestCase
        setup do
          @institution = spina_admin_journal_institutions :rockbottom
          @new_institution = Institution.new
        end

        test 'institution has association affiliations' do
          assert_not_nil @institution.affiliations
          assert @new_institution.affiliations.empty?
        end

        test 'name should not be empty' do
          assert @institution.valid?
          assert_empty @institution.errors[:name]
          @institution.name = nil
          assert @institution.invalid?
          assert_not_empty @institution.errors[:name]
        end
      end
    end
  end
end
