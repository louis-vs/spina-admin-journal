# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Volume} records
      class VolumesController < ApplicationController
        before_action :set_breadcrumb
        before_action :set_volume, only: %i[edit update destroy]

        def index
          @volumes = Volume.all
        end

        def new
          @volume = Volume.new
        end

        def edit; end

        def create
          @volume = Volume.new(volume_params)

          if @volume.save
            # TODO: translation
            redirect_to admin_journal_volumes_path, success: 'Volume saved.'
          else
            render :new
          end
        end

        def update
          if @volume.update(volume_params)
            redirect_to admin_journal_volumes_path, success: 'Volume saved.'
          else
            render :edit
          end
        end

        def destroy
          @volume.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_volumes_path, success: 'Volume deleted.'
            end
          end
        end

        private

        def volume_params
          params.require(:admin_journal_volume).permit(:number, :journal_id)
        end

        def set_breadcrumb
          add_breadcrumb 'Volumes', admin_journal_volumes_path
        end

        def set_volume
          @volume = Volume.find(params[:id])
          add_breadcrumb @volume.title
        end
      end
    end
  end
end
