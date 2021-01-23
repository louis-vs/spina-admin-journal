# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Journal} records.
      # A site only ever has a single journal, so only the {#edit} and {#update} actions
      # are needed.
      class JournalsController < ApplicationController
        PARTS = [
          { name: 'logo', title: 'Logo', partable_type: 'Spina::Image' },
          { name: 'description', title: 'Description', partable_type: 'Spina::Text' }
        ].freeze

        before_action :set_journal
        before_action :set_breadcrumb
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

        def set_breadcrumb
          add_breadcrumb Journal.model_name.human(count: :many), edit_admin_journal_journal_path(@journal.id)
        end

        def set_parts_attributes
          @parts_attributes = PARTS
        end

        def build_parts
          return unless @parts_attributes.is_a? Array

          @journal.parts = @parts_attributes.map do |part_attributes|
            @journal.parts.where(name: part_attributes[:name]).first_or_initialize(**part_attributes)
                    .tap { |part| part.partable ||= part.partable_type.constantize.new }
          end
        end

        def journal_params
          params.require(:admin_journal_journal).permit!
        end
      end
    end
  end
end
