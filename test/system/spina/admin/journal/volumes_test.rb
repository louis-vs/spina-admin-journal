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
        assert_selector '.breadcrumbs' do
          assert_text 'Volumes'
        end
      end

      test 'creating a volume' do
        visit admin_journal_volumes_path
        click_on 'New volume'
        assert_text 'Volume 4 created'
      end

      test 'showing a volume' do
        visit admin_journal_volumes_path

        within "tr[data-id=\"#{@volume.id}\"]" do
          click_on 'View'
        end

        within '.breadcrumbs' do
          assert_text "Volume ##{@volume.number}"
        end

        within 'nav#secondary' do
          click_on 'Issues'
        end

        assert_no_text 'No Issues'
      end

      test 'destroying a volume' do
        visit admin_journal_volumes_path

        within "tr[data-id=\"#{@volume.id}\"]" do
          click_on 'View'
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

        list = find_all('tr[draggable=true]')
        list.last.drag_to list.first, html5: true

        assert_text 'Sorted successfully'
      end

      test 'reordering issues' do
        visit edit_admin_journal_volume_path(@volume)

        within 'nav#secondary' do
          click_on 'Issues'
        end

        list = find_all('tr[draggable=true]')
        list.last.drag_to list.first, html5: true

        assert_text 'Sorted successfully'
      end
    end
  end
end
