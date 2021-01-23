# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Article} records
      class ArticlesController < ApplicationController
        before_action :set_breadcrumb
        before_action :set_article, only: %i[edit update destroy]

        def index
          @articles = Article.all
        end

        def new
          @article = Article.new
        end

        def edit; end

        def create
          @article = Article.new(article_params)
          if @article.save
            # TODO: translation
            redirect_to admin_journal_articles_path, success: 'Article saved.'
          else
            render :new
          end
        end

        def update
          if @article.update(article_params)
            redirect_to admin_journal_articles_path, success: 'Article saved.'
          else
            render :edit
          end
        end

        def destroy
          @article.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_articles_path, success: 'Article deleted.'
            end
          end
        end

        private

        def article_params
          params.require(:admin_journal_article).permit(:title, :issue_id)
        end

        def set_breadcrumb
          add_breadcrumb 'Articles', admin_journal_articles_path
        end

        def set_article
          @article = Article.find(params[:id])
          add_breadcrumb @article.title
        end
      end
    end
  end
end
