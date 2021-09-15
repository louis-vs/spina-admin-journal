# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Author} records and their corresponding {Affiliation}s.
      class AuthorsController < ApplicationController
        before_action :set_breadcrumb
        before_action :set_tabs, except: %i[index destroy]
        before_action :set_author, only: %i[edit update destroy]

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
            redirect_to admin_journal_authors_path, success: t('.saved')
          else
            render :new
          end
        end

        def update
          if @author.update(modified_params)
            redirect_to admin_journal_authors_path, success: t('.saved')
          else
            render :edit
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
          ActiveRecord::Base.transaction do
            sort_params.each do |id, new_pos|
              # ignore uniqueness validation for now
              Authorship.find(id.to_i).update_attribute(:position, new_pos.to_i) # rubocop:disable Rails/SkipsModelValidations
            end
            # do validations after reordering is complete
            validate_sort_order
          end
          render json: { success: true, message: t('.sort_success') }
        rescue ActiveRecord::RecordInvalid
          render json: { success: false, message: t('.sort_error') }
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

        def sort_params
          params.require(:admin_journal_authorships).require(:list).permit!
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

        def validate_sort_order
          Authorship.where(article_id: params[:article_id]).each do |authorship|
            raise ActiveRecord::RecordInvalid if authorship.invalid?
          end
        end
      end
    end
  end
end
