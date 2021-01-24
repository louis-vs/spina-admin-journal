# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Author} records and their corresponding {Affiliation}s.
      class AuthorsController < ApplicationController
        before_action :set_breadcrumb
        before_action :set_author, only: %i[edit update destroy]

        def index
          @authors = Author.all
        end

        def new
          @author = Author.new
          @author.affiliations << Affiliation.new(status: :primary)
        end

        def edit; end

        def create
          @author = Author.new(modified_params)
          if @author.save
            # TODO: translation
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

        private

        def author_params
          params.require(:admin_journal_author).permit(affiliations_attributes: %i[id institution_id first_name
                                                                                   surname])
        end

        def modified_params
          primary_affiliation_index = params[:admin_journal_author][:primary_affiliation_index]
          new_params = author_params
          unless primary_affiliation_index.nil?
            new_params[:affiliations_attributes][primary_affiliation_index][:status] = :primary
          end
          new_params
        end

        def set_breadcrumb
          add_breadcrumb Author.model_name.human(count: :many), admin_journal_authors_path
        end

        def set_author
          @author = Author.find(params[:id])
          add_breadcrumb @author.primary_affiliation.name
        end
      end
    end
  end
end
