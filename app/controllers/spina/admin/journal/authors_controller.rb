# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Author} records and their corresponding {AuthorName}s.
      class AuthorsController < ApplicationController
        before_action :set_breadcrumb
        before_action :set_author, only: %i[edit update destroy]
        before_action :set_author_names, only: %i[edit update destroy]

        def index
          @authors = Author.all
        end

        def new
          @author = Author.new
          @author_name = AuthorName.new
        end

        def edit; end

        def create
          @author = Author.new(author_params)

          if @author.save
            # TODO: translation
            redirect_to admin_journal_authors_path, success: 'Author saved.'
          else
            render :new
          end
        end

        def update
          if @author.update(author_params)
            redirect_to admin_journal_authors_path, success: 'Author saved.'
          else
            render :edit
          end
        end

        def destroy
          @author.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_authors_path, success: 'Author deleted.'
            end
          end
        end

        private

        def author_params
          params.require(:admin_journal_author).permit(:author_names)
        end

        def set_breadcrumb
          add_breadcrumb 'Authors', admin_journal_authors_path
        end

        def set_author
          @author = Author.find(params[:id])
          add_breadcrumb @author.author_names.first
        end
      end
    end
  end
end
