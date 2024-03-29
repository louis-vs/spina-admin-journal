# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Institution} records
      class InstitutionsController < ApplicationController
        before_action :set_breadcrumb
        before_action :set_tabs, except: %i[index destroy]
        before_action :set_institution, only: %i[edit view_affiliations update destroy]

        admin_section :journal_settings

        def index
          @institutions = Institution.all
        end

        def new
          @institution = Institution.new
          add_breadcrumb t('.new')
        end

        def edit; end

        def view_affiliations
          render layout: false
        end

        def create
          @institution = Institution.new(institution_params)

          if @institution.save
            redirect_to edit_admin_journal_institution_path(@institution), success: t('.saved')
          else
            flash.now[:alert] = t('.failed')
            render :new, status: :unprocessable_entity
          end
        end

        def update
          if @institution.update(institution_params)
            redirect_to edit_admin_journal_institution_path(@institution), success: t('.saved')
          else
            flash.now[:alert] = t('.failed')
            render :edit, status: :unprocessable_entity
          end
        end

        def destroy
          @institution.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_institutions_path, success: t('.deleted')
            end
          end
        end

        private

        def institution_params
          params.require(:institution).permit(:name)
        end

        def set_breadcrumb
          add_breadcrumb Institution.model_name.human(count: :many), admin_journal_institutions_path
        end

        def set_tabs
          @tabs = %w[details view_affiliations]
        end

        def set_institution
          @institution = Institution.find(params[:id])
          add_breadcrumb @institution.name
        end
      end
    end
  end
end
