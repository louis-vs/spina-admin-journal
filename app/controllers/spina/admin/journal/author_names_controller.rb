# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {AuthorName} records
      class AuthorNamesController < ApplicationController
        before_action :set_author_name, except: %i[create]

        def create
          @author_name = AuthorName.new(author_name_params)

          if @author_name.save
            # TODO: translation
            redirect_to admin_journal_authors_path, success: 'Author saved.'
          else
            redirect_to admin_journal_authors_path
          end
        end

        def update
          if @author_name.update(author_name_params)
            redirect_to admin_journal_authors_path, success: 'Author saved.'
          else
            redirect_to admin_journal_authors_path
          end
        end

        def destroy
          @author_name.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_authors_path, success: 'Author deleted.'
            end
          end
        end

        private

        def author_name_params
          params.require(:admin_journal_author_name).permit! # (:author_id, :first_name, :surname, :institution_ids)
        end

        def set_author_name
          @author_name = AuthorName.find_by(params[:id])
        end
      end
    end
  end
end
