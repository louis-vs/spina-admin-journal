# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      class IssuesListComponent < ListComponent
        def initialize(issues:)
          @issues = issues
        end

        def before_render
          @list_items = generate_list_items(@issues)
        end

        def call
          render ListComponent.new(list_items: @list_items, sortable: false)
        end

        private

        def generate_list_items(issues)
          issues.map do |issue|
            { id: issue.id,
              label: t('spina.admin.journal.issues.volume_issue', volume_number: issue.volume.number, issue_number: issue.number),
              path: helpers.spina.edit_admin_journal_issue_path(issue.id) }
          end
        end
      end
    end
  end
end
