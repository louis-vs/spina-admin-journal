# frozen_string_literal: true

class AddStatusToSpinaAdminJournalArticles < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    add_column :spina_admin_journal_articles, :status, :integer, null: false, default: 0
  end
end
