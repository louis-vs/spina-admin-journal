# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Issue} records
      class IssuesController < ApplicationController
        PARTS = [
          { name: 'cover_img', title: 'Cover Image', partable_type: 'Spina::Image' },
          { name: 'description', title: 'Description', partable_type: 'Spina::Text' }
        ].freeze

        before_action :set_breadcrumb
        before_action :set_tabs, except: %i[index destroy]
        before_action :set_issue, only: %i[edit update destroy]
        before_action :set_parts_attributes, only: %i[new edit]
        before_action :build_parts, only: %i[edit]

        def index
          @issues = Issue.all
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

        def create
          @issue = Issue.new(issue_params)
          sister_issues = Issue.where(volume: @issue.volume_id)
          @issue.number = sister_issues.any? ? sister_issues.sorted_desc.first.number + 1 : 1

          if @issue.save
            redirect_to admin_journal_issues_path, success: t('.saved')
          else
            render :new
          end
        end

        def update
          if @issue.update(issue_params)
            redirect_to admin_journal_issues_path, success: t('.saved')
          else
            render :edit
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
          success = true
          sort_params.each do |id, new_pos|
            success &&= Issue.update(id.to_i, number: new_pos.to_i)
          end
          render json: { success: success, message: success ? t('.sort_success') : t('.sort_error') }
        end

        private

        def set_issue
          @issue = Issue.find(params[:id])
        end

        def issue_params
          params.require(:admin_journal_issue).permit(:number, :title, :date, :description, :volume_id, :cover_img_id)
        end

        def sort_params
          params.require(:admin_journal_issues).require(:list).permit!
        end

        def set_breadcrumb
          add_breadcrumb Issue.model_name.human(count: :many), admin_journal_issues_path
        end

        def set_tabs
          @tabs = %w[details articles]
        end

        def set_parts_attributes
          @parts_attributes = PARTS
        end

        def build_parts
          return unless @parts_attributes.is_a? Array

          @issue.parts = @parts_attributes.map do |part_attributes|
            @issue.parts.where(name: part_attributes[:name]).first_or_initialize(**part_attributes)
                  .tap { |part| part.partable ||= part.partable_type.constantize.new }
          end
        end
      end
    end
  end
end
