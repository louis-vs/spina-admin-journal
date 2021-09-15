# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Journal} records.
      # A site only ever has a single journal, so the index action is not needed.
      class JournalsController < ApplicationController
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
        PARAMS = [:name, { **CONTENT_PARAMS }].freeze
        PARTS = %w[journal_abbreviation logo description documents issn].freeze

        before_action :set_journal
        before_action :set_parts_attributes
        before_action :build_parts, only: %i[edit]

        def edit
          add_breadcrumb @journal.name
        end

        def update
          if @journal.update(journal_params)
            redirect_to edit_admin_journal_journal_path(@journal), success: t('.saved')
          else
            render :edit
          end
        end

        def destroy
          @journal.destroy
          respond_to do |format|
            format.html do
              redirect_to edit_admin_journal_journal_path(Journal.instance), success: t('.deleted')
            end
          end
        end

        private

        def set_journal
          @journal = Journal.instance
        end

        def set_parts_attributes
          @parts_attributes = current_theme.parts.select { |part| PARTS.include? part[:name] }
        end

        def build_parts
          return unless @parts_attributes.is_a? Array

          @parts = @parts_attributes.collect { |part_attributes| @journal.part(part_attributes) }
        end

        def journal_params
          params.require(:journal).permit(PARAMS)
        end
      end
    end
  end
end
