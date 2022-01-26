# frozen_string_literal: true

require 'application_system_test_case'

module Spina
  module Admin
    module Journal
      class AuthorsTest < ApplicationSystemTestCase
        setup do
          @author = spina_admin_journal_authors :marcus
          authenticate
        end

        test 'visiting the index' do
          visit admin_journal_authors_path
          assert_text 'Authors'
        end

        test 'creating an author' do
          visit admin_journal_authors_path
          click_on 'New author'
          assert_text 'New author'
          fill_in 'author_affiliations_attributes_0_first_name', with: 'Leeroy'
          fill_in 'author_affiliations_attributes_0_surname', with: 'Jenkins'
          select 'Rock Bottom', from: 'author_affiliations_attributes_0_institution_id'

          # check that articles list is empty
          click_on 'Articles'
          assert_text 'There are no items.'

          click_on 'Save author'
          assert_text 'Author saved.'
        end

        test 'updating an author' do
          visit admin_journal_authors_path
          within "li[data-id=\"#{@author.id}\"]" do
            click_on 'Edit'
          end
          assert_text @author.primary_affiliation.name
          fill_in 'author_affiliations_attributes_0_first_name', with: 'No-name'
          click_on 'Save author'
          assert_text 'Author saved'
        end

        test 'destroying an author' do
          skip 'I have no idea how to do this'
          visit admin_journal_authors_path
          within "li[data-id=\"#{@author.id}\"]" do
            click_on 'Edit'
          end
          assert_selector '.relative' do
            assert_text @author.primary_affiliation.name
          end
          accept_alert do
            click_on 'Permanently delete'
          end
          # find '#overlay', visible: true, style: { display: 'block' }
          # assert_text "Are you sure you want to delete the author #{@author.primary_affiliation.name}?"
          # click_on 'Yes, I\'m sure'
          assert_text 'Author deleted'
        end
      end
    end
  end
end
