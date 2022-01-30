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
          assert_text 'Institutions'
        end

        test 'creating an institution' do
          visit admin_journal_institutions_path
          click_on 'New institution'
          assert_text 'New institution'
          fill_in 'institution_name', with: 'New institution'

          # check that affiliations list is empty
          click_button 'Affiliations', class: 'bg-transparent'
          assert_text 'There are no items.'

          click_on 'Save institution'
          assert_text 'Institution saved.'
        end

        test 'updating an institution' do
          visit admin_journal_institutions_path
          within "li[data-id=\"#{@institution.id}\"]" do
            click_on 'Edit'
          end
          assert_text @institution.name
          fill_in 'institution_name', with: 'Updated institution'
          click_on 'Save institution'
          assert_text 'Institution saved'
        end

        test 'destroying an institution' do
          skip 'I have no idea how to do this'
          visit admin_journal_institutions_path
          within "li[data-id=\"#{@institution.id}\"]" do
            click_on 'Edit'
          end
          assert_selector '.relative' do
            assert_text @institution.name
          end
          accept_alert do
            click_on 'Permanently delete'
          end
          # find '#overlay', visible: true, style: { display: 'block' }
          # assert_text "Are you sure you want to delete the institution #{@institution.name}?"
          # click_on 'Yes, I\'m sure'
          assert_text 'Institution deleted'
        end
      end
    end
  end
end
