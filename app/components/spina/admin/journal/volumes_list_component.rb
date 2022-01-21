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
          render ListComponent.new(list_items: @list_items, sortable: false)
        end

        private

        def generate_list_items(volumes)
          volumes.map do |volume|
            { id: volume.id,
              label: Spina::Admin::Journal::Volume.model_name.human,
              path: helpers.spina.edit_admin_journal_volume_path(volume.id) }
          end
        end
      end
    end
  end
end
