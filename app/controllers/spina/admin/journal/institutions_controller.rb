# frozen_string_literal: true

require_dependency 'spina/application_controller'

module Spina
  module Admin
    module Journal
      # Controller for {Institution} records
      class InstitutionsController < ApplicationController
        before_action :set_breadcrumb
        before_action :set_institution, only: %i[edit update destroy]

        def index
          @institutions = Institution.all
        end

        def new
          @institution = Institution.new
        end

        def edit; end

        def create
          @institution = Institution.new(institution_params)

          if @institution.save
            # TODO: translation
            redirect_to admin_journal_institutions_path, success: 'Institution saved.'
          else
            render :new
          end
        end

        def update
          if @institution.update(institution_params)
            redirect_to admin_journal_institutions_path, success: 'Institution saved.'
          else
            render :edit
          end
        end

        def destroy
          @institution.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_institutions_path, success: 'Institution deleted.'
            end
          end
        end

        private

        def institution_params
          params.require(:admin_journal_institution).permit(:name)
        end

        def set_breadcrumb
          add_breadcrumb 'Institutions', admin_journal_institutions_path
        end

        def set_institution
          @institution = Institution.find(params[:id])
          add_breadcrumb @institution.name
        end
      end
    end
  end
end
