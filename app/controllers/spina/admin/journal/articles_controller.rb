# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Article} records.
      class ArticlesController < ApplicationController
        PARTS_PARAMS = [
          :name, :title, :type, :content, :filename, :signed_blob_id, :alt, :attachment_id, :image_id,
          :first_page, :last_page,
          { images_attributes: %i[filename signed_blob_id image_id alt],
            content_attributes: [
              :name, :title,
              { parts_attributes: [
                :name, :title, :type, :content, :filename, :signed_blob_id, :alt, :attachment_id, :image_id,
                { images_attributes: %i[filename signed_blob_id image_id alt] }
              ] }
            ] }
        ].freeze
        CONTENT_PARAMS = Spina.config.locales.inject({}) do |params, locale|
          params.merge("#{locale}_content_attributes": [*PARTS_PARAMS])
        end
        PARAMS = [:issue_id, :licence_id, :title, :url, :doi, :status, { affiliation_ids: [], **CONTENT_PARAMS }].freeze
        PARTS = %w[abstract attachment page_range].freeze

        before_action :set_breadcrumb
        before_action :set_tabs, except: %i[index destroy sort]
        before_action :set_article, only: %i[edit update destroy]
        before_action :set_parts_attributes, only: %i[new edit]
        before_action :build_parts, only: %i[edit]

        def index
          @articles = Article.sorted_desc
        end

        def new
          @article = Article.new
          build_parts
          add_breadcrumb t('.new')
        end

        def edit; end

        def create # rubocop:disable Metrics/AbcSize
          @article = Article.new(article_params)
          sister_articles = Article.where(issue: @article.issue_id)
          @article.number = sister_articles.any? ? sister_articles.sorted_desc.first.number + 1 : 1

          if @article.save
            redirect_to edit_admin_journal_article_path(@article), success: t('.saved')
          else
            flash.now[:alert] = t('.failed')
            render :new, status: :unprocessable_entity
          end
        end

        def update
          if @article.update(article_params)
            redirect_to edit_admin_journal_article_path(@article), success: t('.saved')
          else
            flash.now[:alert] = t('.failed')
            render :edit, status: :unprocessable_entity
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
          params[:ids].each.with_index do |id, index|
            Article.where(id: id).update_all(number: index + 1) # rubocop:disable Rails/SkipsModelValidations
          end
          flash.now[:info] = t('spina.pages.sorting_saved')
          render_flash
        end

        private

        def article_params
          params.require(:article).permit(PARAMS)
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
          @parts_attributes = current_theme.parts.select { |part| PARTS.include? part[:name] }
        end

        def build_parts
          return unless @parts_attributes.is_a? Array

          @parts = @parts_attributes.collect { |part_attributes| @article.part(part_attributes) }
        end
      end
    end
  end
end
