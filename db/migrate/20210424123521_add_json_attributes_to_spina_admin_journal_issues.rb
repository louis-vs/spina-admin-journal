# frozen_string_literal: true

class AddJsonAttributesToSpinaAdminJournalIssues < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    add_column :spina_admin_journal_issues, :json_attributes, :jsonb
  end
end
