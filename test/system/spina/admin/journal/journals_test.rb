# frozen_string_literal: true

require 'application_system_test_case'

module Spina
  module Admin
    module Journal
      class JournalsTest < ApplicationSystemTestCase
        setup do
          @journal = spina_admin_journal_journals :journal
          authenticate
        end

        test 'updating the journal' do
          visit edit_admin_journal_journal_path(@journal)
          assert_selector '.breadcrumbs' do
            assert_text @journal.name
          end
          fill_in 'journal_name', with: 'New journal name'
          click_on 'Save journal'
          assert_text 'Journal saved'
        end

        test 'destroying the journal' do
          visit edit_admin_journal_journal_path(@journal)
          accept_alert do
            click_on 'Permanently delete'
          end
          # find '#overlay', visible: true, style: { display: 'block' }
          # assert_text "Are you sure you want to delete the journal #{@journal.name}?"
          # click_on 'Yes, I\'m sure'
          assert_text 'Journal deleted'
        end
      end
    end
  end
end
