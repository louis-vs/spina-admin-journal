# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Issue} records.
      # TODO: extract methods to helpers to reduce class length
      class IssuesController < ApplicationController
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
        PARAMS = [:volume_id, :title, :date, { **CONTENT_PARAMS }].freeze
        PARTS = %w[cover_img description attachment].freeze

        before_action :set_breadcrumb
        before_action :set_tabs, except: %i[index destroy sort]
        before_action :set_issue, only: %i[edit view_articles update destroy]
        before_action :set_articles, only: %i[edit view_articles update]
        before_action :set_parts_attributes, only: %i[new edit]
        before_action :build_parts, only: %i[edit]

        admin_section :journal

        def index
          @issues = Issue.sorted_desc
        end

        def new
          @issue = Issue.new
          build_parts
          add_breadcrumb t('.new')
        end

        def edit
          add_breadcrumb t('spina.admin.journal.volumes.volume_number', number: @issue.volume.number),
                         edit_admin_journal_volume_path(@issue.volume)
          add_breadcrumb t('spina.admin.journal.issues.issue_number', number: @issue.number)
        end

        def view_articles
          render layout: false
        end

        def create # rubocop:disable Metrics/AbcSize
          @issue = Issue.new(issue_params)
          sister_issues = Issue.where(volume: @issue.volume_id)
          @issue.number = sister_issues.any? ? sister_issues.sorted_desc.first.number + 1 : 1

          if @issue.save
            redirect_to edit_admin_journal_issue_path(@issue), success: t('.saved')
          else
            flash.now[:alert] = t('.failed')
            render :new, status: :unprocessable_entity
          end
        end

        def update
          if @issue.update(issue_params)
            redirect_to edit_admin_journal_issue_path(@issue), success: t('.saved')
          else
            flash.now[:alert] = t('.failed')
            render :edit, status: :unprocessable_entity
          end
        end

        def destroy
          @issue.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_issues_path, success: t('.deleted')
            end
          end
        end

        def sort
          params[:ids].each.with_index do |id, index|
            Issue.where(id: id).update_all(number: index + 1) # rubocop:disable Rails/SkipsModelValidations
          end
          flash.now[:info] = t('spina.pages.sorting_saved')
          render_flash
        end

        private

        def set_issue
          @issue = Issue.find(params[:id])
        end

        def set_articles
          @articles = @issue.articles.sorted_asc
        end

        def issue_params
          params.require(:issue).permit(PARAMS)
        end

        def set_breadcrumb
          add_breadcrumb Issue.model_name.human(count: :many), admin_journal_issues_path
        end

        def set_tabs
          @tabs = %w[details articles]
        end

        def set_parts_attributes
          @parts_attributes = current_theme.parts.select { |part| PARTS.include? part[:name] }
        end

        def build_parts
          return unless @parts_attributes.is_a? Array

          @parts = @parts_attributes.collect { |part_attributes| @issue.part(part_attributes) }
        end
      end
    end
  end
end
