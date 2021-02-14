# frozen_string_literal: true

require 'application_system_test_case'

module Spina
  module Admin
    module Journal
      class InstitutionsTest < ApplicationSystemTestCase
        setup do
          @institution = spina_admin_journal_institutions :rockbottom
          authenticate
        end

        test 'visiting the index' do
          visit admin_journal_institutions_path
          assert_selector '.breadcrumbs' do
            assert_text 'Institutions'
          end
        end

        test 'creating an institution' do
          visit admin_journal_institutions_path
          click_on 'New institution'
          assert_selector '.breadcrumbs' do
            assert_text 'New institution'
          end
          fill_in 'admin_journal_institution_name', with: 'New institution'

          # check that affiliations list is empty
          click_on 'View Affiliations'
          assert_text 'This institution has no associated affiliations.'

          click_on 'Save institution'
          assert_text 'Institution saved.'
        end

        test 'updating an institution' do
          visit admin_journal_institutions_path
          within "tr[data-id=\"#{@institution.id}\"]" do
            click_on 'Edit'
          end
          assert_selector '.breadcrumbs' do
            assert_text @institution.name
          end
          fill_in 'admin_journal_institution_name', with: 'Updated institution'
          click_on 'Save institution'
          assert_text 'Institution saved'
        end

        test 'destroying an institution' do
          visit admin_journal_institutions_path
          within "tr[data-id=\"#{@institution.id}\"]" do
            click_on 'Edit'
          end
          assert_selector '.breadcrumbs' do
            assert_text @institution.name
          end
          click_on 'Permanently delete'
          find '#overlay', visible: true, style: { display: 'block' }
          assert_text "Are you sure you want to delete the institution #{@institution.name}?"
          click_on 'Yes, I\'m sure'
          assert_text 'Institution deleted'
        end
      end
    end
  end
end
