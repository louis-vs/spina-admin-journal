# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Article} records
      class ArticlesController < ApplicationController
        PARTS = [
          { name: 'abstract', title: 'Abstract', partable_type: 'Spina::Text' },
          { name: 'attachment', title: 'Attachment', partable_type: 'Spina::Attachment' }
        ].freeze

        before_action :set_breadcrumb
        before_action :set_tabs, except: %i[index destroy]
        before_action :set_article, only: %i[edit update destroy]
        before_action :set_parts_attributes, only: %i[new edit]
        before_action :build_parts, only: %i[edit]

        def index
          @articles = Article.sorted_desc
        end

        def new
          @article = Article.new
          build_parts
        end

        def edit; end

        def create
          @article = Article.new(article_params)
          sister_articles = Article.where(issue: @article.issue_id)
          @article.number = sister_articles.any? ? sister_articles.sorted_desc.first.number + 1 : 1

          if @article.save
            redirect_to admin_journal_articles_path, success: t('.saved')
          else
            render :new
          end
        end

        def update
          if @article.update(article_params)
            redirect_to admin_journal_articles_path, success: t('.saved')
          else
            render :edit
          end
        end

        def destroy
          @article.destroy
          respond_to do |format|
            format.html do
              redirect_to admin_journal_articles_path, success: t('.deleted')
            end
          end
        end

        def sort
          success = true
          sort_params.each do |id, new_pos|
            success &&= Article.update(id.to_i, number: new_pos.to_i)
          end
          render json: { success: success, message: success ? t('.sort_success') : t('.sort_error') }
        end

        private

        def article_params
          params.require(:admin_journal_article).permit!
        end

        def sort_params
          params.require(:admin_journal_articles).require(:list).permit!
        end

        def set_breadcrumb
          add_breadcrumb Article.model_name.human(count: :many), admin_journal_articles_path
        end

        def set_tabs
          @tabs = %w[details authors]
        end

        def set_article
          @article = Article.find(params[:id])
          add_breadcrumb @article.title
        end

        def set_parts_attributes
          @parts_attributes = PARTS
        end

        def build_parts
          return unless @parts_attributes.is_a? Array

          @article.parts = @parts_attributes.map do |part_attributes|
            @article.parts.where(name: part_attributes[:name]).first_or_initialize(**part_attributes)
                    .tap { |part| part.partable ||= part.partable_type.constantize.new }
          end
        end
      end
    end
  end
end
