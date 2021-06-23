# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Licence} records.
      class LicencesController < ApplicationController
        PARTS_PARAMS = [
          :name, :title, :type, :content, :filename, :signed_blob_id, :alt, :attachment_id, :image_id,
          { images_attributes: %i[filename signed_blob_id image_id alt],
            content_attributes: [
              :name, :title,
              { parts_attributes: [
                :name, :title, :type, :content, :filename, :signed_blob_id, :alt, :attachment_id, :image_id,
                { images_attributes: %i[filename signed_blob_id image_id alt] }
              ] }
            ] }
        ].freeze
        CONTENT_PARAMS = Spina.config.locales.inject({}) do |params, locale|
          params.merge("#{locale}_content_attributes": [*PARTS_PARAMS])
        end
        PARAMS = [:name, :abbreviated_name, { **CONTENT_PARAMS }].freeze
        PARTS = %w[text url logo].freeze

        before_action :set_breadcrumb
        before_action :set_licence, only: %i[edit update destroy]
        before_action :set_parts_attributes, only: %i[new edit]
        before_action :build_parts, only: %i[edit]

        def index
          @licences = Licence.sorted
        end

        def new
          @licence = Licence.new
          build_parts
          add_breadcrumb t('.new')
        end

        def edit; end

        def create
          @licence = Licence.new(licence_params)
          if @licence.save
            redirect_to admin_journal_licences_path, success: t('.saved')
          else
            render :new
          end
        end

        def update
          if @licence.update(licence_params)
            redirect_to admin_journal_licences_path, success: t('.saved')
          else
            render :edit
          end
        end

        def destroy
          @licence.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_licences_path, success: t('.deleted')
            end
          end
        end

        private

        def licence_params
          params.require(:admin_journal_licence).permit(PARAMS)
        end

        def set_breadcrumb
          add_breadcrumb Licence.model_name.human(count: :many), admin_journal_licences_path
        end

        def set_licence
          @licence = Licence.find(params[:id])
          add_breadcrumb @licence.name
        end

        def set_parts_attributes
          @parts_attributes = current_theme.parts.select { |part| PARTS.include? part[:name] }
        end

        def build_parts
          return unless @parts_attributes.is_a? Array

          @parts = @parts_attributes.collect { |part_attributes| @licence.part(part_attributes) }
        end
      end
    end
  end
end
