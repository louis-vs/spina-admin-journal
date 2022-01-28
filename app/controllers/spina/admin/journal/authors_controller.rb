# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Author} records and their corresponding {Affiliation}s.
      class AuthorsController < ApplicationController
        before_action :set_breadcrumb
        before_action :set_tabs, except: %i[index destroy]
        before_action :set_author, only: %i[edit update destroy]

        admin_section :journal_settings

        def index
          @authors = Author.all
        end

        def new
          @author = Author.new
          @author.affiliations << Affiliation.new(status: :primary)
          add_breadcrumb t('.new')
        end

        def edit; end

        def create
          @author = Author.new(modified_params)
          if @author.save
            redirect_to edit_admin_journal_author_path(@author), success: t('.saved')
          else
            flash.now[:alert] = t('.failed')
            render :new, status: :unprocessable_entity
          end
        end

        def update
          if @author.update(modified_params)
            redirect_to edit_admin_journal_author_path(@author), success: t('.saved')
          else
            flash.now[:alert] = t('.failed')
            render :edit, status: :unprocessable_entity
          end
        end

        def destroy
          @author.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_authors_path, success: t('.deleted')
            end
          end
        end

        def sort
          params[:ids].each.with_index do |id, index|
            Authorship.where(id: id).update_all(position: index + 1) # rubocop:disable Rails/SkipsModelValidations
          end
          flash.now[:info] = t('spina.pages.sorting_saved')
          render_flash
        end

        private

        def author_params
          params.require(:author).permit(:primary_affiliation_index,
                                         affiliations_attributes: %i[id institution_id first_name
                                                                     surname])
        end

        def modified_params
          primary_affiliation_index = params[:author][:primary_affiliation_index]
          new_params = author_params.except :primary_affiliation_index
          unless new_params[:affiliations_attributes].nil? || primary_affiliation_index.nil?
            new_params[:affiliations_attributes].each_key do |index|
              new_params[:affiliations_attributes][index][:status] = index == primary_affiliation_index ? 'primary' : 'other' # rubocop:disable Layout/LineLength
            end
          end
          new_params
        end

        def set_breadcrumb
          add_breadcrumb Author.model_name.human(count: :many), admin_journal_authors_path
        end

        def set_tabs
          @tabs = %w[details articles]
        end

        def set_author
          @author = Author.find(params[:id])
          add_breadcrumb @author.primary_affiliation.name
        end
      end
    end
  end
end
