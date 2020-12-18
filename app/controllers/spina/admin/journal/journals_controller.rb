# frozen_string_literal: true

require_dependency 'spina/application_controller'

module Spina
  module Admin
    module Journal
      # Controller for {Journal} objects
      class JournalsController < AdminController
        before_action :set_breadcrumb
        before_action :set_journal, only: %i[edit update destroy]

        layout 'spina/admin/admin'

        def index
          @journals = Journal.all
        end

        def new
          @journal = Journal.new
        end

        def edit; end

        def create
          @journal = Journal.new(journal_params)

          if @journal.save
            redirect_to admin_journal_journals_path, notice: 'Journal was successfully created.'
          else
            render :new
          end
        end

        def update
          if @journal.update(journal_params)
            redirect_to admin_journal_journals_path, notice: 'Journal was successfully updated.'
          else
            render :edit
          end
        end

        def destroy
          @journal.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_journals_path, notice: 'Journal was successfully destroyed.'
            end
          end
        end

        private

        def journal_params
          params.require(:admin_journal_journal).permit(:name)
        end

        def set_breadcrumb
          add_breadcrumb 'Journals', admin_journal_journals_path
        end

        def set_journal
          @journal = Journal.find(params[:id])
          add_breadcrumb @journal.name
        end
      end
    end
  end
end
