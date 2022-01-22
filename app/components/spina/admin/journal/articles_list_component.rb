# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      class ArticlesListComponent < ListComponent
        def initialize(articles:)
          @articles = articles
        end

        def before_render
          @list_items = generate_list_items(@articles)
        end

        def call
          render ListComponent.new(list_items: @list_items, sortable: false)
        end

        private

        def generate_list_items(articles)
          articles.map do |article|
            { id: article.id,
              label: generate_label(article),
              path: helpers.spina.edit_admin_journal_article_path(article.id) }
          end
        end

        def generate_label(article)
          t('spina.admin.journal.articles.article_number', volume_number: article.issue.volume.number, # rubocop:disable Style/StringConcatenation
                                                           issue_number: article.issue.number,
                                                           article_number: article.number
          ) + ' | ' + t('spina.admin.journal.articles.title_author', title: article.title, # rubocop:disable Layout/MultilineMethodCallBraceLayout Layout/SpaceInsideParens
                                                                     author: article.affiliations.map(&:surname).join(', ')) # rubocop:disable Layout/LineLength
        end
      end
    end
  end
end
