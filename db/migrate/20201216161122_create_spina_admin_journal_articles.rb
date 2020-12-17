# frozen_string_literal: true

class CreateSpinaAdminJournalArticles < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_articles do |t|
      t.integer :order, null: false
      t.string :title, null: false
      t.string :url, null: false, default: ''
      t.string :doi, null: false, default: ''
      t.text :abstract, null: false, default: ''
      t.references :issue, null: false, foreign_key: { to_table: :spina_admin_journal_issues }
      t.references :file, null: true, foreign_key: { to_table: :spina_attachments, on_delete: :nullify }

      t.timestamps
    end
  end
end
