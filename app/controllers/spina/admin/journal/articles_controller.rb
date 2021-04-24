# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Controller for {Article} records.
      class ArticlesController < ApplicationController
        PARTS_PARAMS = [
          :name, :title, :type, :content, :filename, :signed_blob_id, :alt, :attachment_id, :image_id,
          images_attributes: %i[filename signed_blob_id image_id alt],
          content_attributes: [
            :name, :title,
            parts_attributes: [
              :name, :title, :type, :content, :filename, :signed_blob_id, :alt, :attachment_id, :image_id,
              images_attributes: %i[filename signed_blob_id image_id alt]
            ]
          ]
        ].freeze
        CONTENT_PARAMS = Spina.config.locales.inject({}) { |params, locale| params.merge("#{locale}_content_attributes": [*PARTS_PARAMS]) }
        PARAMS = [:issue_id, :title, :url, :doi, affiliation_ids: [], **CONTENT_PARAMS].freeze
        PARTS = %w[abstract attachment].freeze

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
          ActiveRecord::Base.transaction do
            sort_params.each do |id, new_pos|
              Article.find(id.to_i).update_attribute(:number, new_pos.to_i) # rubocop:disable Rails/SkipsModelValidations
            end
            validate_sort_order
          end
          render json: { success: true, message: t('.sort_success') }
        rescue ActiveRecord::RecordInvalid
          render json: { success: false, message: t('.sort_error') }
        end

        private

        def article_params
          params.require(:admin_journal_article).permit(PARAMS)
        end

        def sort_params
          params.require(:admin_journal_articles).require(:list).permit!
        end

        def validate_sort_order
          Article.where(issue_id: params[:issue_id]).each do |article|
            raise ActiveRecord::RecordInvalid if article.invalid?
          end
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
