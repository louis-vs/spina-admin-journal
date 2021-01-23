# frozen_string_literal: true

require_dependency 'spina/application_controller'

module Spina
  module Admin
    module Journal
      # Controller for {Issue} records
      class IssuesController < ApplicationController
        before_action :set_breadcrumb
        before_action :set_issue, only: %i[edit update destroy]

        def index
          @issues = Issue.all
        end

        def new
          @issue = Issue.new
        end

        def edit; end

        def create
          @issue = Issue.new(issue_params)

          if @issue.save
            # TODO: translation
            redirect_to admin_journal_issues_path, success: 'Issue saved.'
          else
            render :new
          end
        end

        def update
          if @issue.update(issue_params)
            redirect_to admin_journal_issues_path, success: 'Issue saved.'
          else
            render :edit
          end
        end

        def destroy
          @issue.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_issues_path, success: 'Issue deleted.'
            end
          end
        end

        private

        def issue_params
          params.require(:admin_journal_issue).permit(:number, :title, :date, :description, :volume_id, :cover_img_id)
        end

        def set_breadcrumb
          add_breadcrumb 'Issues', admin_journal_issues_path
        end

        def set_issue
          @issue = Issue.find(params[:id])
          add_breadcrumb @issue.title
        end
      end
    end
  end
end
