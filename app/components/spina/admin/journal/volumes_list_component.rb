# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      class VolumesListComponent < ListComponent
        def initialize(volumes:)
          @volumes = volumes
        end

        def before_render
          @list_items = generate_list_items(@volumes)
        end

        def call
          render ListComponent.new(list_items: @list_items,
                                   sortable: true,
                                   sort_path: helpers.spina.sort_admin_journal_volumes_path(Journal.instance.id))
        end

        private

        def generate_list_items(volumes)
          volumes.map do |volume|
            { id: volume.id,
              label: t('spina.admin.journal.volumes.volume_number', number: volume.number),
              path: helpers.spina.edit_admin_journal_volume_path(volume.id) }
          end
        end
      end
    end
  end
end
