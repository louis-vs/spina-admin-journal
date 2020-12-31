# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      class ArticlesController < AdminController
        before_action :set_breadcrumb
        before_action :set_article, only: %i[edit update destroy]

        layout 'spina/admin/admin'

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
            redirect_to admin_journal_journal_articles_path(params[:journal_id]), notice: 'Article was successfully created.'
          else
            render :new
          end
        end

        def update
          if @article.update(article_params)
            redirect_to admin_journal_journal_articles_path(params[:journal_id]), notice: 'Article was successfully updated.'
          else
            render :edit
          end
        end

        def destroy
          @article.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_journal_articles_path(params[:journal_id]), notice: 'Article was successfully destroyed.'
            end
          end
        end

        private

        def article_params
          params.require(:admin_journal_article).permit(:title, :abstract)
        end

        def set_breadcrumb
          add_breadcrumb 'Articles', admin_journal_journal_articles_path(params[:journal_id])
        end

        def set_article
          @article = Article.find(params[:id])
          add_breadcrumb @article.title
        end
      end
    end
  end
end
