class AddJsonAttributesToSpinaAdminJournalArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :spina_admin_journal_articles, :json_attributes, :jsonb
  end
end
