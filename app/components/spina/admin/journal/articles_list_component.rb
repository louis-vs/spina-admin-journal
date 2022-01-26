# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # (articles are only sortable if they are within an issue)
      class ArticlesListComponent < ListComponent
        attr_reader :sortable

        def initialize(articles:, sortable: false)
          @articles = articles
          @sortable = sortable
        end

        def before_render
          @list_items = generate_list_items(@articles)
        end

        def call
          render ListComponent.new(list_items: @list_items,
                                   sortable: sortable?,
                                   sort_path: (@articles.any? ? helpers.spina.sort_admin_journal_issues_path(@articles.first.issue.id) : ''))
        end

        def sortable?
          sortable
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
                        author: article.authorships.sorted_within_article.map{ |authorship| authorship.affiliation.surname }.join(', ')) # rubocop:disable Layout/LineLength
        end
      end
    end
  end
end
