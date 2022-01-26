# frozen_string_literal: true

require 'application_system_test_case'

module Admin
  module Journal
    class VolumesTest < ApplicationSystemTestCase
      setup do
        @volume = spina_admin_journal_volumes :vol1
        authenticate
      end

      test 'visiting the index' do
        visit admin_journal_volumes_path
        assert_text 'Volumes'
      end

      test 'creating a volume' do
        visit admin_journal_volumes_path
        click_on 'New volume'
        assert_text 'Volume 4 created'
      end

      test 'showing a volume' do
        visit admin_journal_volumes_path

        within "li[data-id=\"#{@volume.id}\"]" do
          click_on 'Edit'
        end

        assert_text "Volume ##{@volume.number}"

        click_button 'Issues'

        assert_no_text 'No Issues'
      end

      test 'destroying a volume' do
        skip 'I have no idea how to do this'
        visit admin_journal_volumes_path

        within "li[data-id=\"#{@volume.id}\"]" do
          click_on 'Edit'
        end

        accept_alert do
          click_on 'Permanently delete'
        end
        # find '#overlay', visible: true, style: { display: 'block' }
        # assert_text "Are you sure you want to delete Volume ##{@volume.number}?"
        # click_on 'Yes, I\'m sure'
        assert_text 'Volume deleted'
      end

      test 'reordering volumes' do
        visit admin_journal_volumes_path

        list = find_all('.cursor-move')
        list.last.drag_to list.first

        assert_text 'Sorting saved'
      end

      test 'reordering issues' do
        visit edit_admin_journal_volume_path(@volume)

        click_button 'Issues', class: 'bg-transparent'

        list = find_all('.cursor-move')
        list.last.drag_to list.first

        assert_text 'Sorting saved'
      end
    end
  end
end
