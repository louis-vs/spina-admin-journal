# frozen_string_literal: true

require_dependency 'spina/application_controller'

module Spina
  module Admin
    module Journal
      # Controller for {Journal} objects
      class JournalsController < ApplicationController
        PARTS = [
          { name: 'logo', title: 'Logo', partable_type: 'Spina::Image' }
        ].freeze

        before_action :set_journal, only: %i[edit update destroy]
        before_action :set_breadcrumb
        before_action :set_parts_attributes, only: %i[new edit]
        before_action :build_parts, only: %i[edit]

        def index
          @journals = Journal.all
        end

        def new
          @journal = Journal.new
          build_parts
          add_breadcrumb t('.new')
        end

        def edit
          add_breadcrumb @journal.name
        end

        def create
          @journal = Journal.new(journal_params)

          if @journal.save
            redirect_to admin_journal_journals_path, notice: t('.created', name: @journal.name)
          else
            render :new
          end
        end

        def update
          if @journal.update(journal_params)
            redirect_to admin_journal_journals_path, notice: t('.updated', name: @journal.name)
          else
            render :edit
          end
        end

        def destroy
          @journal.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_journals_path, notice: t('.destroyed', name: @journal.name)
            end
          end
        end

        private

        def set_breadcrumb
          add_breadcrumb Journal.model_name.human(count: :many), admin_journal_journals_path
        end

        def set_journal
          @journal = Journal.find(params[:id])
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
          params.require(:admin_journal_journal).permit(:name,
                                                        parts_attributes:
                                                          [:id, :title, :name, :partable_type, :partable_id,
                                                           { partable_attributes:
                                                               [:id, :content, :image_tokens, :image_positions, :date, :time,
                                                                { structure_items_attributes:
                                                                    [:id, :position, :_destroy,
                                                                     { structure_parts_attributes:
                                                                         [:id, :title, :structure_partable_type, :name, :partable_id,
                                                                          { partable_attributes: {} }] }] }] }])
        end
      end
    end
  end
end
