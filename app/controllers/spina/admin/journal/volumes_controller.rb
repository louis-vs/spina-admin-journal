# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Volume} records
      class VolumesController < ApplicationController
        before_action :set_breadcrumb
        before_action :set_tabs, except: %i[index destroy]
        before_action :set_volume, only: %i[edit destroy]

        def index
          @volumes = Volume.sorted_asc
        end

        def edit; end

        def create
          @volume = Volume.new
          @volume.journal_id = Journal.instance.id
          @volume.number = Volume.any? ? Volume.sorted_desc.first.number + 1 : 1
          @volume.save!
          redirect_to admin_journal_volumes_path, success: t('.created', number: @volume.number)
        rescue ActiveRecord::RecordNotUnique
          # can only happen because of some race condition where two Volumes are created at the same time
          retry
        end

        def destroy
          @volume.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_volumes_path, success: 'Volume deleted.'
            end
          end
        end

        def sort
          ActiveRecord::Base.transaction do
            sort_params.each do |id, new_pos|
              # ignore uniqueness validation for now
              Volume.find(id.to_i).update_attribute(:number, new_pos.to_i) # rubocop:disable Rails/SkipsModelValidations
            end
            validate_sort_order
          end
          render json: { success: true, message: t('.sort_success') }
        rescue ActiveRecord::RecordInvalid
          render json: { success: false, message: t('.sort_error') }
        end

        private

        def sort_params
          params.require(:admin_journal_volumes).require(:list).permit!
        end

        def validate_sort_order
          Volume.where(journal_id: params[:journal_id]).each do |volume|
            raise ActiveRecord::RecordInvalid if volume.invalid?
          end
        end

        def set_breadcrumb
          add_breadcrumb Volume.model_name.human(count: :many), admin_journal_volumes_path
        end

        def set_volume
          @volume = Volume.find(params[:id])
          add_breadcrumb t('spina.admin.journal.volumes.volume_number', number: @volume.number)
        end

        def set_tabs
          @tabs = %w[details issues]
        end
      end
    end
  end
end
